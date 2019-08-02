import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/consuletion_child_page.dart';

class RelationshipPage extends StatefulWidget {
  RelationshipPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RelationshipPageState();
  }
}
class _RelationshipPageState extends State<RelationshipPage> {

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return ChildPage(true);
  }
}
