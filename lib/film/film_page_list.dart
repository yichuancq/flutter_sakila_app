import 'package:app/vo/film_json_convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:toast/toast.dart';

import 'film_list_response.dart';

class AlbumsPageList extends StatefulWidget {
  //
  AlbumsPageList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FilmListState();
  }
}

class _FilmListState extends State<AlbumsPageList>
    with TickerProviderStateMixin {
  List<Data> _filmList = new List();
  int _totalPage = 0;
  int _pageNum = 1;
  int _pageSize = 20;
  int _currentPage = 1;

  ///
  Widget _filmItemBuilder(final int position) {
    //获取电影的单项
    Data filmItem = _filmList[position];
    return GestureDetector(
      onTap: () {},
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
              padding: EdgeInsets.all(5.0),
              child: _filmItemBuilder(position),
            );
          }),
    );
  }

  Widget _filmListBuilder() {
    return Container(
      child: ListView(
        children: [
          _filmsList(),
        ],
      ),
    );
  }

  //上拉
  Future _onRefresh() async {
    print("_onRefresh...");
    await Future.delayed(Duration(seconds: 2), () {
      if (_pageNum - 1 <= 0) {
        Toast.show("没有数据了！", context);
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
        Toast.show("没有数据了！", context);
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

  ///分页
  Widget _filmPageListRefresh() {
    return new EasyRefresh(
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: _filmsList(),
    );
  }

  //实现构建方法
  _viewBuild() {
    Size size = MediaQuery.of(context).size;
    if (_filmList == null) {
      // 加载菊花
      return Center(
        child: CupertinoActivityIndicator(),
      );
      //
    } else {
      return new Container(
        height: size.height,
        child: _filmPageListRefresh(),
      );
    }
  }

  /// 数据加载
  void loadData() async {
    print("on loadData...");
    //json 转换
//    FilmListResponse filmListResponse = await convertFromJson();
    FilmListResponse filmListResponse = await getHttpFilmsData();
    //读取json
    if (filmListResponse != null && filmListResponse.data != null) {
      _filmList = filmListResponse.data;
      print("list size: ${_filmList.length}");
      //更新列表
    }
    setState(() {
      //状态
    });
  }

  void getPageData() async {
    FilmListResponse filmListResponse = await getHttpFilmsData();
    if (filmListResponse != null && filmListResponse.data != null) {
      _filmList = filmListResponse.data;
//      _pageNum = trackDto.data.pageNum;
//      _pageSize = trackDto.data.pageSize;
      print("_pageNum： ${_pageNum}");
    } else {
      Toast.show("获取数据失败！", context);
    }
    //更新列表
    setState(() {
      //状态
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("电影专辑", style: TextStyle(fontSize: 15)),
        centerTitle: true,
      ),
      body: _viewBuild(),
    );
  }
}
