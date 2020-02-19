import 'package:flutter/material.dart';

import 'work_dynamics_page.dart';

class Work extends StatefulWidget {
  @override
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<Work> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff2CA687),
        title: Text(
          '工作动态',
        ),
      ),
      body: WorkDynamics(),
    );
  }
}
