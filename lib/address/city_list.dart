import 'package:app/vo/city_json_convert.dart';
import 'package:app/vo/city_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:toast/toast.dart';

import 'city_list_item.dart';

int countryIdParams;

class CityPageList extends StatefulWidget {
  int countryId;

  CityPageList({Key key, @required this.countryId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    countryIdParams = this.countryId;
    return _CityPageListState();
  }
}

class _CityPageListState extends State<CityPageList> {
  Data _cityData;
  List<Data> _cityList = new List();
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
    CityResponse cityResponse =
        await getHttpCityData(_pageNum, _pageSize, countryIdParams);
    //读取json
    if (cityResponse != null && cityResponse.data != null) {
      _cityList = cityResponse.data;
      //filmListResponse.totalPage 后端表的总记录数量
      //总页数
      //函数向上舍入为最接近的整数
      _totalPage = (cityResponse.totalPage / _pageSize).ceil();
      print("list size: ${_cityList.length}");
      print("_totalPage： ${_totalPage}");
      //更新列表
    }
    setState(() {
      //状态
    });
  }

  ///
  void getPageData() async {
    CityResponse cityResponse =
        await getHttpCityData(_pageNum, _pageSize, countryIdParams);
    if (cityResponse != null && cityResponse.data != null) {
      _cityList = cityResponse.data;
      //总页数
      //函数向上舍入为最接近的整数
      _totalPage = (cityResponse.totalPage / _pageSize).ceil();
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
            Data data = _cityList[index];
            return CityListItem(cityItem: data, context: context);
          }, childCount: _cityList.length),
        ),
      ],
      // child: _filmsList(),
    );
  }

  //实现构建方法
  Widget _viewBuild() {
    Size size = MediaQuery.of(context).size;
    if (_cityList == null || _totalPage == 0) {
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
    _cityList = null;
    super.dispose();
  }

  ///title
  Widget _title() {
    return Text(
        (_cityList == null || _totalPage == 0)
            ? "loading..."
            : "city ${_pageNum} of ${_totalPage}",
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
