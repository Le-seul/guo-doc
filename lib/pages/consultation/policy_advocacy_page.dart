import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/consuletion_child_page.dart';


class PolicyAdvocacyPage extends StatefulWidget {
  PolicyAdvocacyPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PolicyAdvocacyPageState();
  }
}

class _PolicyAdvocacyPageState extends State<PolicyAdvocacyPage> {
    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return ChildPage(true);
    }
}
