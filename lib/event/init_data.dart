import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/bean/chunyu_message.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:flutter_first/bloc/bloc_provider.dart';
import 'package:flutter_first/bloc/chunyu_bloc.dart';
import 'package:flutter_first/bloc/step_count.bloc.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/db/order_db.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/consultation_detail_page.dart';
import 'package:flutter_first/pages/home/doctor/talk_page.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/util/storage_manager.dart';
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
  ChunyuPushBloc _chunyuPushBloc;
  StepCountBloc _stepCountBloc;
  Timer localTimer;
  int count = 0;
  ChunyuMessage chunyuMessage = new ChunyuMessage();

  @override
  void initState() {
    super.initState();
    registrationID =
        StorageManager.sharedPreferences.getString(Constant.registrationID);
    init();
    _chunyuPushBloc = BlocProvider.of<ChunyuPushBloc>(context);
    _stepCountBloc = BlocProvider.of<StepCountBloc>(context);

    if (Platform.isAndroid) {
      localTimer = Timer.periodic(Duration(seconds: 10), (timer) {
        count++;
//        print('时间count:${count}');
        getStep().then((val) {
            _stepCountBloc.sink.add(val);
            if(count%30 == 0){
              _updateStepCount(val);
            }

        });
      });
    }
  }

  _updateStepCount(int val){
    DioUtils.instance.requestNetwork<String>(Method.post, Api.UPDATESTEPTCOUNT,
        queryParameters: {
          'stepCount': val,
        }, onSuccess: (data) {
          print('上传步数成功!');
        }, onError: (code, msg) {
          print('上传步数失败!');
        });
  }

  Future<int> getStep() async {
    // Native channel
    const platform = const MethodChannel("cn.gov.gaj.phms.v3/player"); //分析1
    int result = 0;
    try {
      result = await platform.invokeMethod("step"); //分析2
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
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

          print("flutter 接收到推送消息0: ${json.encode(message)}");
          print("flutter 接收到推送消息1: $message");
          print("flutter 接收到推送消息2: ${message["extras"]}");
          print("flutter 接收到推送消息3: ${message["extras"]["cn.jpush.android.EXTRA"]}");
          print("flutter 接收到推送消息4: ${json.decode(message["extras"]["cn.jpush.android.EXTRA"])["model"]}");

          String content = _map['message'];
          String model = _map['model'];
          String target = _map['target'];
          String time = _map['time'];
          String type = _map['type'];
          print('极光推送封装数据：{message:$content, target:$target, time:$time, model:$model, type:$type}');

          if(model == 'chunyuTuwen'){
            _initChunyu(model, target);
          }else if(model == 'chunyuFastphone'){
          _initChunyu(model, target);
          }


        },
        onOpenNotification: (Map<String, dynamic> message) {
          // 点击通知栏消息，在此时通常可以做一些页面跳转等
          Map<String, dynamic> _map =
          json.decode(message["extras"]["cn.jpush.android.EXTRA"]);

          print("flutter 接收到推送消息0: ${json.encode(message)}");
          print("flutter 接收到推送消息1: $message");
          print("flutter 接收到推送消息2: ${message["extras"]}");
          print("flutter 接收到推送消息3: ${message["extras"]["cn.jpush.android.EXTRA"]}");
          print("flutter 接收到推送消息4: ${json.decode(message["extras"]["cn.jpush.android.EXTRA"])["model"]}");

          String content = _map['message'];
          String model = _map['model'];
          String target = _map['target'];
          String time = _map['time'];
          String type = _map['type'];
          print('极光推送封装数据：{message:$content, target:$target, time:$time, model:$model, type:$type}');

          if(model == 'chunyuTuwen' || model == 'chunyuFastphone'){
            NavigatorUtil.pushPage(context,TalkPage(orderId: target,offstage: false,type: model,));
          }else if(model == 'article'){
            NavigatorUtil.pushPage(context,ConsultationDetailPage(id: target,));
//            CommonRequest.UserReadingLog(item.id, item.type, 'YD');
          }
          String orderId = json
              .decode(message["extras"]["cn.jpush.android.EXTRA"])["orderId"];
          print("orderid：$orderId");

        },
      );
    }
  }

  _initChunyu(String type,String orderId) async{
    int num = 0;
    print("orderId:$orderId");
    OrderNum orderNum = await db.getOrder(orderId);
    print('orderNum:${orderNum.toString()}');
    if (orderNum == null) {
      num++;
      print("num1：$num");
      int currentTime = DateTime.now().hour;
      int count = await db.saveOrder(orderId, type, "$num", currentTime);
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
    notify();
  }

  notify() async{
    List<Map> list = await db.getAllOrder();
//    print("数据库list3:$list");
    List<OrderNum> listNum = List();
    for (Map map in list) {
      listNum.add(OrderNum.fromJson(map));
    }
    int intTuWen = 0;
    int intFastPhone = 0;
    for (OrderNum orderNum in listNum) {
      setState(() {
        if (orderNum.location == "chunyuTuwen") {
          intTuWen = int.parse(orderNum.num) + intTuWen;
        } else {
          intFastPhone = int.parse(orderNum.num) + intFastPhone;
        }
      });
    }
    print('电话推送数：$intFastPhone');
    chunyuMessage.tuwenNum = intTuWen;
    chunyuMessage.fastPhoneNum = intFastPhone;
    _chunyuPushBloc.sink.add(chunyuMessage);
  }
  static saveRegistrationID(String registrationID) async {
    await StorageManager.sharedPreferences
        .setString(Constant.registrationID, registrationID);
  }

  @override
  void dispose() {
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
