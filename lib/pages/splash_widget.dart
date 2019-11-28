import 'package:flutter/material.dart';
import 'package:flutter_first/util/navigator_util.dart';


import 'login_page.dart';
//启动页面
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      NavigatorUtil.pushReplacementNamed(context, LoginPage());
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