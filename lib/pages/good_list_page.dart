import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/net/mock_request.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/dialog.dart';
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
  void getMock() async{
    var result = await MockRequest.get('douban');
    var abd = result['subjects'];
    ad = abd.toString();
    Toast.show(ad);
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
                              Toast.show("这是一个Toast",duration: 2000);
                            });
                          },
                          onError: (code, msg) {
                            setState(() {
                              ad = msg;
                              Toast.show("强制退出");
                            });
                          },
                        );

//                        getMock();
                      },
                    ),
                    new RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/login", (Route<dynamic> route) => false);
                      },
                      child: new Text("点击退出登录"),
                    ),
                    new Text(ad == null ? "": ad ),
                  ],
                ),
              );
            },
            childCount: 6,
          ),
        )));


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
    MyDialog.showMyMaterialDialog(context);
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
              new RaisedButton(
                  onPressed: () {
                    MyDialog.showMyMaterialDialog(context);
                  },
                  child: new Text("显示SimpleDialog,Material风格")),
              new RaisedButton(
                  onPressed: () {
                    MyDialog.showMyMaterialDialog(context);
                  },
                  child: new Text("显示AlertDialog,Material风格")),
              new RaisedButton(
                  onPressed: () {
                    MyDialog.showMyCupertinoDialog(context);
                  },
                  child: new Text("显示AlertDialog,IOS风格")),
              new RaisedButton(
                  onPressed: () {
                    MyDialog.showMyDialogWithValue(context);
                  },
                  child: new Text("显示一个有返回值的对话框")),
              new RaisedButton(
                  onPressed: () {
                    MyDialog.showMyDialogWithColumn(context);
                  },
                  child: new Text("显示一个SingleChildScrollView+Column的对话框")),
              new RaisedButton(
                  onPressed: () {
                    MyDialog.showMyDialogWithListView(context);
                  },
                  child: new Text("显示一个ListView的对话框")),
              new RaisedButton(
                  onPressed: () {
                    MyDialog.showMyDialogWithStateBuilder(context);
                  },
                  child: new Text("显示一个StatefulBuilder的对话框")),
              new RaisedButton(
                  onPressed: () {
                    MyDialog.showMyCustomLoadingDialog(context);
                  },
                  child: new Text("显示一个自定义的对话框")),
            ],
        
          ),
        ),
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
