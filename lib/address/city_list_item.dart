import 'package:app/vo/city_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 简单列表项
class CityListItem extends StatelessWidget {
  ///country

  final BuildContext context;

  /// date item
  final Data cityItem;

  /// 宽度
  final double width;

  const CityListItem({
    this.cityItem,
    this.context,
    Key key,
    this.width = double.infinity,
  }) : super(key: key);

  ///卡片布局
  Widget _widgetPadding() {
    return Padding(
      padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 0),
      child: Container(
        color: Colors.white,
        height: 80,
        width: width,
        child: ListTile(
          //标题
          title: Text("城市名称:${cityItem.city}"),
          //电影描述
          subtitle: Text("修改时间:${cityItem.lastUpdate}"),
          //电影的Id
          trailing: Text("${cityItem.cityId}"),
        ),
      ),
    );
  }

  ///点击事件
  Widget _widgetCardItem() {
    return GestureDetector(
      onTap: () {},
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
