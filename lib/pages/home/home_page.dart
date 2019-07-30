import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/event/login_event.dart';
//主页，显示一个列表
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription exitLogin;
  @override
  void initState() {
    super.initState();
    //获取商品数据
    exitLogin = eventBus.on<LoginEvent>().listen((event) {
      Future.delayed(Duration(seconds: 3)).then((value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    //取消订阅
    exitLogin.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('主页'),
        backgroundColor: Colors.orange,
      ),
      body: new Container(
          child: new ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return new ListTile(
                  title: new Text("第$index项"),
                  onTap: () {
                    Navigator.of(context).pushNamed("/detail");
//                    Navigator.of(context)
//                        .push(new MaterialPageRoute(builder: (context) {
//                      return new DetailPage();
//                    })
//                    );
                  },
                );
              })),
    );
  }
}

