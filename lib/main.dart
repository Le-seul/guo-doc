import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/pages/splash_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'pages/good_list_page.dart';

import 'package:jpush_flutter/jpush_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  JPush jpush = new JPush();
  final SystemUiOverlayStyle _style =SystemUiOverlayStyle(statusBarColor: Colors.transparent);
//  StreamSubscription exitLogin;
  @override
  void initState() {
//    exitLogin = eventBus.on<LoginEvent>().listen((event) {
//        Navigator.of(context)
//            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
//    });

    jpush.setup(appKey: "29b0c3835843e02814ff021a" ,channel: 'developer-default');
    // 监听jpush
    jpush.addEventHandler(
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter 接收到推送: $message");
      },
      onOpenNotification: (Map<String, dynamic> message) {
        // 点击通知栏消息，在此时通常可以做一些页面跳转等
      },
    );

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
          title: 'Dio请求',
          //debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: new Center(
                child: SplashPage(),
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
