import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/toast.dart';

//商品列表页面
class GoodListPage extends StatefulWidget {
  _GoodListPageState createState() => _GoodListPageState();
}

class _GoodListPageState extends State<GoodListPage> {
  String ad;

  @override
  void initState() {
    super.initState();
    //获取商品数据
  }

  List<Container> _buildGridTitleList(int count) {
    return new List<Container>.generate(
        count,
        (int index) => new Container(
              child: new Image.asset('assets/images/${index + 1}.jpeg'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dio请求'),
          backgroundColor: Color(0xff666666),
        ),
        body: new Center(
            child: new PageView.custom(
          childrenDelegate: new SliverChildBuilderDelegate(
            (context, index) {
              return new Center(
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("网络请求强制退出"),
                      onPressed: () {
                        DioUtils.instance.requestNetwork<String>(
                          Method.get, "/signController/sign",
                          queryParameters: {"deviceType": 3, "userId": 15},
                          onSuccess: (data) {
                            setState(() {
                              ad = "你好";
                              Toast.show("这是一个Toast");
                            });
                          },
                          onError: (code, msg) {
                            setState(() {
                              ad = msg;
                              Toast.show("强制退出");
                            });
                          },
                        );
                      },
                    ),
                    new RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/login", (Route<dynamic> route) => false);
                      },
                      child: new Text("点击退出登录"),
                    ),
                    new Text(ad == null?"":ad),
                  ],
                ),
              );
            },
            childCount: 6,
          ),
        )));
  }
}

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

//详细界面
class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情页'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: new Container(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text("详细界面"),
              new RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/goodList");
                },
                child: new Text("点击再跳转"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
              Navigator.of(context).pushReplacementNamed("/home");
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
                        return new HomePage();
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

//路由跳转失败的页面
class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: new Center(
          child: new Text("NotFoundPage"),
        ),
      ),
    );
  }
}
