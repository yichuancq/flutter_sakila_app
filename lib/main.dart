import 'package:flutter/material.dart';

import 'menu/menu_page.dart';
main() {
  runApp(MyApp());
}
//https://javiercbk.github.io/json_to_dart/
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MenuPage(),
    );
  }
}
