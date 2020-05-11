import 'package:app/vo/country_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'city_list.dart';

/// 简单列表项
class CountryListItem extends StatelessWidget {
  final BuildContext context;

  /// date item
  final Data countryItem;

  /// 宽度
  final double width;

  const CountryListItem({
    this.countryItem,
    this.context,
    Key key,
    this.width = double.infinity,
  }) : super(key: key);

  ///country
  void onTab() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new CityPageList(countryId: countryItem.countryId);
    }));
    print("onTabCountryInfo..");
  }

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
          title: Text("国家:${countryItem.country}"),
          //电影描述
          subtitle: Text("修改时间:${countryItem.lastUpdate}"),
          //电影的Id
          trailing: Text("${countryItem.countryId}"),
        ),
      ),
    );
  }

  ///点击事件
  Widget _widgetCardItem() {
    return GestureDetector(
      onTap: onTab,
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
