import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmptyPageState();
  }
}

class EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("EmptyPage", style: TextStyle(fontSize: 15)),
      ),
      backgroundColor: Colors.grey[200],
      body: Text(""),
    );
  }
}
