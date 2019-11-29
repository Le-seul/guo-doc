import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/util/storage_manager.dart';


//商品列表页面
class ExitLoginPage extends StatefulWidget {
  _ExitLoginPageState createState() => _ExitLoginPageState();
}

class _ExitLoginPageState extends State<ExitLoginPage> {


  @override
  void initState() {
    super.initState();
    //获取商品数据
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('系统设置'),
          backgroundColor: Color(0xff2CA687),
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
                      onPressed: () {
                        StorageManager.exite();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/login", (Route<dynamic> route) => false);
                      },
                      child: new Text("点击退出登录"),
                    ),
                  ],
                ),
              );
            },
            childCount: 6,
          ),
        )));
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
