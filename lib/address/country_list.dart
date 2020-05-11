import 'package:app/address/country_list_response.dart';
import 'package:app/vo/country_json_convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:toast/toast.dart';

import 'country_list_item.dart';

class CountryPageList extends StatefulWidget {
  CountryPageList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CountryPageListState();
  }
}

class _CountryPageListState extends State<CountryPageList> {
  List<Data> _countryList = new List();
  int _pageNum = 1;
  int _pageSize = 50;
  int _totalPage = 0;
  int _currentPage = 1;

  //上拉
  Future _onRefresh() async {
    print("_onRefresh...");
    await Future.delayed(Duration(seconds: 2), () {
      if (_pageNum - 1 <= 0) {
        Toast.show("已经到达顶部,没有数据了！", context);
        return;
      }
      if (_pageNum > 0 &&
          _pageNum <= _totalPage &&
          _currentPage >= 1 &&
          _currentPage <= _totalPage) {
        //load
        _pageNum -= 1;
        _currentPage -= 1;
        getPageData();
        setState(() {});
      }
    });
  }

  ///下拉
  Future _onLoad() async {
    print("_onLoad...");
    await Future.delayed(Duration(seconds: 2), () {
      if (_pageNum >= _totalPage) {
        Toast.show("已经到达尾部,没有数据了！", context);
        return;
      }
      if (_pageNum > 0 &&
          _pageNum <= _totalPage &&
          _currentPage >= 1 &&
          _currentPage <= _totalPage) {
        //load
        _pageNum += 1;
        _currentPage += 1;
        getPageData();
      }
      setState(() {});
    });
  }

  /// 数据加载
  void loadData() async {
    print("on loadData...");
    //json 转换
    CountryResponse filmListResponse =
        await getHttpCountryData(_pageNum, _pageSize);
    //读取json
    if (filmListResponse != null && filmListResponse.data != null) {
      _countryList = filmListResponse.data;
      //filmListResponse.totalPage 后端表的总记录数量
      //总页数
      //函数向上舍入为最接近的整数
      _totalPage = (filmListResponse.totalPage / _pageSize).ceil();
      print("list size: ${_countryList.length}");
      print("_totalPage： ${_totalPage}");
      //更新列表
    }
    setState(() {
      //状态
    });
  }

  ///
  void getPageData() async {
    CountryResponse filmListResponse =
        await getHttpCountryData(_pageNum, _pageSize);
    if (filmListResponse != null && filmListResponse.data != null) {
      _countryList = filmListResponse.data;
      //总页数
      //函数向上舍入为最接近的整数
      _totalPage = (filmListResponse.totalPage / _pageSize).ceil();
      print("_pageNum： ${_pageNum}");
      print("_totalPage： ${_totalPage}");
    } else {
      Toast.show("获取数据失败！", context);
    }
    //更新列表
    setState(() {
      //状态
    });
  }

  ///分页
  Widget _filmPageListRefresh() {
    return EasyRefresh.custom(
      header: MaterialHeader(),
      footer: MaterialFooter(),
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            Data data = _countryList[index];
            return CountryListItem(countryItem: data, context: context);
          }, childCount: _countryList.length),
        ),
      ],
      // child: _filmsList(),
    );
  }

  //实现构建方法
  Widget _viewBuild() {
    Size size = MediaQuery.of(context).size;
    if (_countryList == null || _totalPage == 0) {
      // 加载菊花
      return Center(
        child: CupertinoActivityIndicator(),
      );
      //
    } else {
      return new Container(
        height: size.height,
        //分页
        child: _filmPageListRefresh(),
      );
    }
  }

  ///初始化
  @override
  void initState() {
    super.initState();
    loadData();
  }

  ///释放
  @override
  dispose() {
    _countryList = null;
    super.dispose();
  }

  ///title
  Widget _title() {
    return Text(
        (_countryList == null || _totalPage == 0)
            ? "loading..."
            : "country ${_pageNum} of ${_totalPage}",
        style: TextStyle(fontSize: 15));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: _title(),
        centerTitle: true,
      ),
      body: _viewBuild(),
    );
  }
}
