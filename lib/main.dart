import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/data/global_user_data.dart';
import 'package:flutter_first/db/order_db.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/music/lryic.dart';
import 'package:flutter_first/music/page_playing.dart';
import 'package:flutter_first/music/player.dart';
import 'package:flutter_first/pages/container_page.dart';
import 'package:flutter_first/pages/login_page.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/serviceLocator.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'pages/exit_login_page.dart';

void main() async {
// 注册服务
  setupLocator();
// 运行主界面
  await StorageManager.init();



  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final model = PlayingLyric(quiet);
  String token;
  String registrationID = '';
  var db = OrderDb();
  GlobalUserData globalUserData = GlobalUserData();

  final SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
//  StreamSubscription exitLogin;
  @override
  void initState() {
//    exitLogin = eventBus.on<LoginEvent>().listen((event) {
//        Navigator.of(context)
//            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
//    });

    token = StorageManager.sharedPreferences.getString(Constant.access_Token);
    registrationID = StorageManager.sharedPreferences.getString(Constant.registrationID);
    init();
  }

  init(){
    if (Platform.isAndroid) {
      JPush jpush = StorageManager.jpush;

      if(registrationID==null){
        jpush.getRegistrationID().then((rid) {
          setState(() {
            print("获取注册的极光id:$rid");
            saveRegistrationID(rid);
          });
        });
      }
      jpush.setup(
          appKey: "565a2f927e82c11287326979",
          channel: 'developer-default');

      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
//                print("flutter 接收到推送消息1: ${json.encode(message)}");
          print("flutter 接收到推送消息1: $message");
          print("flutter 接收到推送消息2: ${message["extras"]}");
          print(
              "flutter 接收到推送消息3: ${message["extras"]["cn.jpush.android.EXTRA"]}");
//                print("flutter 接收到推送消息5: ${message["extras"]["cn.jpush.android.EXTRA"]["orderId"]}");
          print(
              "flutter 接收到推送消息4: ${json.decode(message["extras"]["cn.jpush.android.EXTRA"])["orderId"]}");

          int num = 0;
          String type = json.decode(
              message["extras"]["cn.jpush.android.EXTRA"])["location"];
          print("type:$type");
          String orderId = json.decode(
              message["extras"]["cn.jpush.android.EXTRA"])["orderId"];
          print("orderId:$orderId");
          OrderNum orderNum = await db.getOrder(orderId);
          print('orderNum:${orderNum.toString()}');
          if (orderNum == null) {
            num++;
            print("num1：$num");
            int currentTime = DateTime.now().hour;
            int count = await db.saveOrder(orderId, type, "$num",currentTime);
            List<Map> list = await db.getAllOrder();
            print("数据库list1:$list");
          } else {
            num = int.parse(orderNum.num) ?? 0;
            num++;
            print("num2：$num");
            int count = await db.updateOrder(orderId, "$num");
            List<Map> list= await db.getAllOrder();
            print("数据库list2:$list");
          }
          eventBus
              .fire(refreshNum("$num", orderId: orderId, location: type));
        },
        onOpenNotification: (Map<String, dynamic> message) {
          // 点击通知栏消息，在此时通常可以做一些页面跳转等
          String orderId = json.decode(
              message["extras"]["cn.jpush.android.EXTRA"])["orderId"];
          print("orderid：$orderId");
          Toast.show('点击通知');
          Router.push(context, Router.talk,
              {'orderId': orderId, 'offstage': false});
        },
      );
    }
  }


  @override
  void didChangeDependencies() {

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
    return DataProviderWidget(
      data: globalUserData,
      child: OKToast(
          child: ScopedModel<PlayingLyric>(
              model: model,
              child: Quiet(
                child: MaterialApp(
                  //定义路由
                  //没有路由可以进行匹配的时候
                  debugShowCheckedModeBanner: false,
                  onUnknownRoute: (RouteSettings setting) {
                    String name = setting.name;
                    print("onUnknownRoute:$name");
                    return new MaterialPageRoute(builder: (context) {
                      return new NotFoundPage();
                    });
                  },
                  routes: <String, WidgetBuilder>{
                    '/login': (BuildContext context) => new LoginPage(),
                    '/playing': (BuildContext context) => new PlayingPage(),
                  },
                  title: 'Dio请求',
                  //debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: new Center(
                      child: (token == null || token == '')
                          ? LoginPage()
                          : ContainerPage(),
                    ),
                  ),
                  theme: new ThemeData(
                    platform: TargetPlatform.iOS,
                  ),
                ),
              )),
          backgroundColor: Colors.black54,
          textPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          radius: 20.0,
          position: ToastPosition.bottom,
          dismissOtherOnShow: true),
    );
  }
}
