import 'package:app/page/film_list_item.dart';
import 'package:app/vo/film_json_convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:toast/toast.dart';

import 'film_list_response.dart';

class FilmPageList extends StatefulWidget {
  FilmPageList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FilmListState();
  }
}

class _FilmListState extends State<FilmPageList> {
  List<Data> _filmList = new List();
  int _pageNum = 1;
  int _pageSize = 50;
  int _totalPage = 0;
  int _currentPage = 1;

  ///
  Widget _filmItemBuilder(int position) {
    //获取电影的单项
    Data filmItem = _filmList[position];
    return GestureDetector(
      onTap: () {
        print(" on item click...");
      },
      child: Container(
        height: 80,
        color: Colors.white,
        child: ListTile(
          //标题
          title: Text(filmItem.title),
          //电影描述
          subtitle: Text(filmItem.description),
          //电影的Id
          trailing: Text(filmItem.fid == null ? "" : filmItem.fid.toString()),
        ),
      ),
    );
  }

  ///
  Widget _filmsList() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: _filmList == null ? 0 : _filmList.length,
          separatorBuilder: (BuildContext context, int index) {
            return new Container(color: Colors.grey);
          },
          itemBuilder: (BuildContext context, int position) {
            return Padding(
              padding: EdgeInsets.all(4.0),
              child: _filmItemBuilder(position),
            );
          }),
    );
  }

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
//   FilmListResponse filmListResponse = await convertFromJson();
    FilmListResponse filmListResponse =
        await getHttpFilmsData(_pageNum, _pageSize);
    //读取json
    if (filmListResponse != null && filmListResponse.data != null) {
      _filmList = filmListResponse.data;
      //filmListResponse.totalPage 后端表的总记录数量
      //总页数
      //函数向上舍入为最接近的整数
      _totalPage = (filmListResponse.totalPage / _pageSize).ceil();
      print("list size: ${_filmList.length}");
      print("_totalPage： ${_totalPage}");
      //更新列表
    }
    setState(() {
      //状态
    });
  }

  ///
  void getPageData() async {
    FilmListResponse filmListResponse =
        await getHttpFilmsData(_pageNum, _pageSize);
    if (filmListResponse != null && filmListResponse.data != null) {
      _filmList = filmListResponse.data;
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
            Data data = _filmList[index];
            return FilmListItem(filmItem: data);
          }, childCount: _filmList.length),
        ),
      ],
      // child: _filmsList(),
    );
  }

  //实现构建方法
  Widget _viewBuild() {
    Size size = MediaQuery.of(context).size;
    if (_filmList == null || _totalPage == 0) {
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
    _filmList = null;
    super.dispose();
  }

  ///title
  Widget _title() {
    return Text(
        (_filmList == null || _totalPage == 0)
            ? "loading..."
            : "电影专辑 ${_pageNum} of ${_totalPage}",
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
