import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/consuletion_child_page.dart';

class SelectedPage extends StatefulWidget {
  SelectedPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SelectedPageState();
  }
}
class _SelectedPageState extends State<SelectedPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ChildPage(false);
  }
}
