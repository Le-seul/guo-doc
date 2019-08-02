import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/consuletion_child_page.dart';

class PhysiologyPage extends StatefulWidget {
  PhysiologyPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PhysiologyPageState();
  }
}

class _PhysiologyPageState extends State<PhysiologyPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChildPage(true);
  }
}
