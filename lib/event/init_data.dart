import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/db/order_db.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class InitData extends StatefulWidget {
  Widget child;

  InitData({Key key, this.child}) : super(key: key);
  @override
  _InitDataState createState() => _InitDataState();
}

class _InitDataState extends State<InitData> {
  String registrationID = '';
  var db = OrderDb();

  @override
  void initState() {
    super.initState();
    registrationID =
        StorageManager.sharedPreferences.getString(Constant.registrationID);
    init();
  }

  init() {
    if (Platform.isAndroid) {
      JPush jpush = StorageManager.jpush;

      if (registrationID == null) {
        jpush.getRegistrationID().then((rid) {
          setState(() {
            print("获取注册的极光id:$rid");
            saveRegistrationID(rid);
          });
        });
      }
      jpush.setup(
          appKey: "565a2f927e82c11287326979", channel: 'developer-default');
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          Map<String, dynamic> _map =
              json.decode(message["extras"]["cn.jpush.android.EXTRA"]);

//          print("flutter 接收到推送消息0: ${json.encode(message)}");
//          print("flutter 接收到推送消息1: $message");
//          print("flutter 接收到推送消息2: ${message["extras"]}");
//          print("flutter 接收到推送消息3: ${message["extras"]["cn.jpush.android.EXTRA"]}");
//          print("flutter 接收到推送消息4: ${json.decode(message["extras"]["cn.jpush.android.EXTRA"])["model"]}");
          String content = _map['content'];
          String displayType = _map['displayType'];
          String model = _map['model'];
          String time = _map['time'];
          String type = _map['type'];
          print('极光推送封装数据：{content:$content, displayTape:$displayType, time:$time, mode$model, type:$type}');
          int num = 0;
          String type1 = json
              .decode(message["extras"]["cn.jpush.android.EXTRA"])["location"];
          print("type1:$type1");
          String orderId = json
              .decode(message["extras"]["cn.jpush.android.EXTRA"])["orderId"];
          print("orderId:$orderId");
          OrderNum orderNum = await db.getOrder(orderId);
          print('orderNum:${orderNum.toString()}');
          if (orderNum == null) {
            num++;
            print("num1：$num");
            int currentTime = DateTime.now().hour;
            int count = await db.saveOrder(orderId, type1, "$num", currentTime);
            List<Map> list = await db.getAllOrder();
            print("数据库list1:$list");
          } else {
            num = int.parse(orderNum.num) ?? 0;
            num++;
            print("num2：$num");
            int count = await db.updateOrder(orderId, "$num");
            List<Map> list = await db.getAllOrder();
            print("数据库list2:$list");
          }
          eventBus.fire(refreshNum("$num", orderId: orderId, location: type));
        },
        onOpenNotification: (Map<String, dynamic> message) {
          // 点击通知栏消息，在此时通常可以做一些页面跳转等
          String orderId = json
              .decode(message["extras"]["cn.jpush.android.EXTRA"])["orderId"];
          print("orderid：$orderId");
          Toast.show('点击通知');
          Router.push(
              context, Router.talk, {'orderId': orderId, 'offstage': false});
        },
      );
    }
  }

  static saveRegistrationID(String registrationID) async {
    await StorageManager.sharedPreferences
        .setString(Constant.registrationID, registrationID);
  }

  @override
  void dispose() {
//    exitLogin.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
