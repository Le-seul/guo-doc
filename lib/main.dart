import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/pages/container_page.dart';
import 'package:flutter_first/pages/login_page.dart';
import 'package:flutter_first/pages/splash_widget.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:oktoast/oktoast.dart';
import 'pages/exit_login_page.dart';

import 'package:jpush_flutter/jpush_flutter.dart';

void main() async{
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {

    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  JPush jpush = new JPush();
  String token;

  final SystemUiOverlayStyle _style =SystemUiOverlayStyle(statusBarColor: Colors.transparent);
//  StreamSubscription exitLogin;
  @override
  void initState() {
//    exitLogin = eventBus.on<LoginEvent>().listen((event) {
//        Navigator.of(context)
//            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
//    });

    token = StorageManager.sharedPreferences.getString(Constant.access_Token);
    SchedulerBinding.instance.addPostFrameCallback((_) => {
      jpush.setup(appKey: "565a2f927e82c11287326979" ,channel: 'developer-default'),
        // 监听jpush
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter 接收到推送: $message");
        },
        onOpenNotification: (Map<String, dynamic> message) {
        // 点击通知栏消息，在此时通常可以做一些页面跳转等v
          Toast.show('点击通知');
          Router.pushNoParams(context, Router.sleepRecordsPage);
        },
      ),
    });
  }

  @override
  void dispose() {
//    exitLogin.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return OKToast(
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
          routes:  <String, WidgetBuilder> {
          '/login': (BuildContext context) => new LoginPage(),
        },
          title: 'Dio请求',
          //debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: new Center(
                child: (token == null || token == '') ? LoginPage():ContainerPage(),
            ),
          ),
          theme: new ThemeData(
              platform: TargetPlatform.iOS,
             ),

        ),
        backgroundColor: Colors.black54,
        textPadding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom,
        dismissOtherOnShow: true
    );
  }
}
