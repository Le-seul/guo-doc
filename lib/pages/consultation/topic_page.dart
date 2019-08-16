import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/consultation_child_page.dart';

class TopicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text('专题'),
        centerTitle: true,
      ),
      body: ChildPage(true),
    );
  }
}
