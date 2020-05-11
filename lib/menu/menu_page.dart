import 'package:app/film/film_page_list.dart';
import 'package:app/home/home.dart';
import 'package:app/me/me.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MenuPageState();
  }
}

class MenuPageState extends State<MenuPage> {
  int index = 0;

  buildBodyPage() {
    if (index == 0) {
      return HomePage();
    }
    if (index == 1) {
      return FilmPageList();
    }
    if (index == 2) {
      return MePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey,
      body: buildBodyPage(),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text("首页", style: TextStyle(color: Colors.grey)),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.data_usage),
            title: new Text("数据", style: TextStyle(color: Colors.grey)),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text("我", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
