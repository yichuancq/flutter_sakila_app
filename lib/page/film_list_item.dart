import 'package:app/vo/film_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 简单列表项
class FilmListItem extends StatelessWidget {
  /// date item
  final Data filmItem;
  /// 宽度
  final double width;
  const FilmListItem({
    this.filmItem,
    Key key,
    this.width = double.infinity,
  }) : super(key: key);

  ///卡片布局
  Widget _widgetPadding() {
    return Padding(
      padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 0),
      child: Container(
        color: Colors.white,
        height: 90,
        width: width,
        child: ListTile(
          //标题
          title: Text(filmItem.title),
          //电影描述
          subtitle: Text(filmItem.description),
          //电影的Id
          trailing: Text("${filmItem.fid}"),
        ),
      ),
    );
  }

  ///点击事件
  Widget _widgetCardItem() {
    return GestureDetector(
      onTap: () {
        print("on tab:${filmItem.fid}");
      },
      child: _widgetPadding(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: _widgetCardItem(),
    );
    //return
  }
}
