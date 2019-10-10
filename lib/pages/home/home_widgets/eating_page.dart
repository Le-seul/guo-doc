import 'package:flutter/material.dart';


class Eating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('健康评估'),
        centerTitle: true,
      ),
      body: PageView(
        controller: PageController(
          initialPage: 0,
          viewportFraction: 1.0,
        ),
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text('222222')
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text('222222')
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text('222222')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
