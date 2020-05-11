import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:app/vo/staff_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 简单列表项
class StaffListItem extends StatelessWidget {
  /// date item
  final Data staffItem;

  /// 宽度
  final double width;

  const StaffListItem({
    this.staffItem,
    Key key,
    this.width = double.infinity,
  }) : super(key: key);

  ///头像
  Widget _rowHeader() {
    if (staffItem != null &&
        staffItem.picture != null &&
        staffItem.picture.length > 0) {
      String pictureTxt = "${staffItem.picture}";
      //将Base64字符串的图片转换成图片
      Uint8List decodeTxt = convert.base64.decode(pictureTxt);
      return ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: new Image.memory(
          decodeTxt,
          width: 80, fit: BoxFit.fitWidth,
          gaplessPlayback: true, //防止重绘
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Container(
          height: 80,
          width: 80,
          color: Colors.grey[200],
        ),
      );
    }
  }

  ///卡片布局
  Widget _widgetPadding() {
    return Padding(
      padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 0),
      child: Container(
          color: Colors.white,
          height: 140,
          width: width,
          child: Row(
            children: [
              //头像
              SizedBox(width: 4),
              _rowHeader(),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 4.0, right: 4.0),
                    //height: 130.0,
                    child: Column(
//                  // 从左到右
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //内
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: new Row(
                                  // 对齐方式
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("姓名：",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15.0)),
                                    Text(
                                        "${staffItem.firstName},${staffItem.lastName}"),
                                    // myDegreeText(stationDto.degree),
                                  ]),
                            ),
                          ),
                          //缠绕布局，防止溢出
                          Wrap(
                            children: [
                              Text("邮箱：",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15.0)),
                              Text(
                                "${staffItem.email}",
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              //线路code和名称
                              child: Text("地址:${staffItem.address}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                  softWrap: false, //文本是否能换行
                                  maxLines: 4),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text("国籍:${staffItem.country}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13)),
                          ),

                          Expanded(
                            flex: 1,
                            child: Text("城市：${staffItem.city},",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text("修改时间 ${staffItem.lastUpdate}",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 13)),
                          ),
                        ])),
              ),
              new Icon(Icons.navigate_next),
            ],
          )),
    );
  }

  ///点击事件
  Widget _widgetCardItem() {
    return GestureDetector(
      onTap: () {
        print("on tab:${staffItem.staffId}");
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
