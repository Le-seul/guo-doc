import 'package:flutter/material.dart';

class ImagesPage extends StatelessWidget {
  var indext;
  ImagesPage({Key key,@required this.indext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:  Center(
          child: Text('这是图片$indext'),
        ),
      ),
    );
  }
}