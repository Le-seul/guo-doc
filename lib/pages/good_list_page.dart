import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/net/mock_request.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/login_page.dart';
import 'package:flutter_first/util/dialog.dart';
import 'package:flutter_first/util/storage_manager.dart';
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

  void getMock() async {
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
                          Method.get,
                          "/signController/sign",
                          queryParameters: {"deviceType": 3, "userId": 15},
                          onSuccess: (data) {
                            setState(() {
                              ad = "你好";
                              Toast.show("这是一个Toast", duration: 2000);
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
                        exite();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/login", (Route<dynamic> route) => false);
                      },
                      child: new Text("点击退出登录"),
                    ),
                    new Text(ad == null ? "" : ad),
                  ],
                ),
              );
            },
            childCount: 6,
          ),
        )));
  }
  static exite() async {
    await StorageManager.sharedPreferences.setString(Constant.access_Token, '');
  }
}

//路由跳转失败的页面
class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) => _buildItem(index),
      ),
    );
  }

  _buildItem(int index) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('这是一级列表'),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => _buildItem1(index),
          ),
        ],
      ),
    );
  }

  _buildItem1(int index) {
    return Slider(
      onChanged: (newValue) {
      },
      value:  0.5,);
  }
}
