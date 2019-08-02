import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/consuletion_child_page.dart';

class FeelingPage extends StatefulWidget {
  FeelingPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeelingPageState();
  }
}

class _FeelingPageState extends State<FeelingPage> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChildPage(true);

  }
}