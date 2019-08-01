import 'package:flutter/material.dart';
import 'package:flutter_first/pages/container_page.dart';

import 'package:flutter_first/util/router.dart';

import 'good_list_page.dart';
//登录界面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录页'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text("这是登录界面"),
          new RaisedButton(
            child: new Text("点击登录成功，跳转到主页"),
            onPressed: () {
              Router.pushNoParams(context, Router.containerPage);
            },
          ),
          new RaisedButton(
            child: new Text("点击跳转到NotFoundPage"),
            onPressed: () {
//              跳转到路由错误的界面
              Navigator.of(context).pushNamed("/111");
            },
          ),
          new RaisedButton(
            child: new Text("点击登录成功，自定义动画，跳转到主页"),
            onPressed: () {
//              自定义跳转动画
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      opaque: true,
                      pageBuilder: (BuildContext context, _, __) {
                        return new ContainerPage();
                      },
                      transitionsBuilder: (context, Animation<double> animation,
                          Animation<double> secondaryAnimation, Widget child) {
                        return FadeTransition(
                          opacity: animation,
                          child: RotationTransition(
                            turns: Tween<double>(begin: 0.5, end: 1.0)
                                .animate(animation),
                            child: child,
                          ),
                        );
                      }));
            },
          ),
        ],
      ),
    );
  }
}