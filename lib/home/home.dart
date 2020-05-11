import 'package:app/address/country_list.dart';
import 'package:app/staff/staff_list.dart';
import 'package:app/util/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  ///country
  void onTabCountryInfo() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new CountryPageList();
    }));
    print("onTabCountryInfo..");
  }

  //StaffPageList
  void onTabStaffInfo() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new StaffPageList();
    }));
    print("onTabCountryInfo..");
  }

  ///menu
  Widget _gridViewMenu() {
    return new Container(
      //padding
      padding: EdgeInsets.all(20),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //每行2个
          mainAxisSpacing: 10.0, //主轴方向间距
          crossAxisSpacing: 10.0, //水平方向间距
          childAspectRatio: 1.5, //纵轴缩放比例
        ),
        children: <Widget>[
//          marqueeWidget(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: MyButton(
              onPress: onTabCountryInfo,
              title: Text("地址信息",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              iconButton: new IconButton(
                  icon: new Icon(
                Icons.place,
                size: 30,
                color: Colors.blue,
              )),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: MyButton(
              onPress: onTabStaffInfo,
              title: Text("员工信息",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              iconButton: new IconButton(
                  icon: new Icon(
                Icons.person,
                size: 30,
                color: Colors.lightGreen,
              )),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: MyButton(
              onPress: () {},
              title: Text("影片管理",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              iconButton: new IconButton(
                  icon: new Icon(
                Icons.videocam,
                size: 30,
                color: Colors.amberAccent,
              )),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: MyButton(
              onPress: () {},
              title: Text("客户信息",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              iconButton: new IconButton(
                  icon: new Icon(
                Icons.person_outline,
                size: 30,
                color: Colors.orange,
              )),
            ),
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: MyButton(
              onPress: () {},
              title: Text("租赁管理",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              iconButton: new IconButton(
                  icon: new Icon(
                Icons.business_center,
                size: 30,
                color: Colors.yellow,
              )),
            ),
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: MyButton(
              onPress: () {},
              title: Text("库存管理",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              iconButton: new IconButton(
                  icon: new Icon(
                Icons.store,
                size: 30,
                color: Colors.blueAccent,
              )),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: MyButton(
              onPress: () {},
              title: Text("演员信息",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              iconButton: new IconButton(
                  icon: new Icon(
                Icons.star,
                size: 30,
                color: Colors.blueAccent,
              )),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: MyButton(
              onPress: () {},
              title: Text("more",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              iconButton: new IconButton(
                  icon: new Icon(
                Icons.more_horiz,
                size: 30,
                color: Colors.lightBlue,
              )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("首页", style: TextStyle(fontSize: 15)),
      ),
      backgroundColor: Colors.grey[200],
      body: _gridViewMenu(),
    );
  }
}
