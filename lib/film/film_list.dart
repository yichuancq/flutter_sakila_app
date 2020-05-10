import 'package:app/vo/film_json_convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'film_list_response.dart';

class AlbumsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FilmListState();
  }
}

class _FilmListState extends State<AlbumsList> with TickerProviderStateMixin {
  List<Data> _filmList = new List();

  ///
  Widget _albumItemBuilder(final int position) {
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
              child: _albumItemBuilder(position),
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

  /// 数据加载
  void loadData() async {
    print("on loadData...");
    //json 转换
    FilmListResponse filmListResponse = await convertFromJson();
    if (filmListResponse != null) {
      //读取json
      _filmList = filmListResponse.data;
      print("list size: ${_filmList.length}");
      //更新列表
    }
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
        title: Text("电影专辑列表", style: TextStyle(fontSize: 15)),
        centerTitle: true,
      ),
      body: _filmListBuilder(),
    );
  }
}
