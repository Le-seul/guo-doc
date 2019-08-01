import 'package:flutter/material.dart';

class Search_bar extends StatefulWidget {
  @override
  _Search_barState createState() => _Search_barState();
}

class _Search_barState extends State<Search_bar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "输入搜索内容",
        contentPadding:EdgeInsets.all(10),
      ),
    );
  }
}
