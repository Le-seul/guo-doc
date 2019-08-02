import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/consuletion_child_page.dart';


var numb = 0;

class Occcupation extends StatefulWidget {
  Occcupation({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OcccupationState();
  }
}

class _OcccupationState extends State<Occcupation> {
    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return ChildPage(true);
    }
}
