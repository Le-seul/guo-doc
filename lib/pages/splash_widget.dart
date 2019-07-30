import 'package:flutter/material.dart';
//启动页面
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacementNamed("/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('启动页'),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: new Center(
          child: new Text("启动界面"),
        ),
      ),
    );
  }
}