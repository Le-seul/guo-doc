import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/music/lryic.dart';
import 'package:flutter_first/music/player.dart';
import 'package:flutter_first/pages/container_page.dart';
import 'package:flutter_first/pages/login_page.dart';
import 'package:flutter_first/util/config.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'pages/exit_login_page.dart';

void main() async {
  Config.env = Env.TEST;
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

  final SystemUiOverlayStyle _style =SystemUiOverlayStyle(statusBarColor: Colors.transparent);
//  StreamSubscription exitLogin;
  @override
  void initState() {
//    exitLogin = eventBus.on<LoginEvent>().listen((event) {
//        Navigator.of(context)
//            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
//    });

    token = StorageManager.sharedPreferences.getString(Constant.access_Token);

  }

  @override
  void dispose() {
//    exitLogin.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return OKToast(
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
        dismissOtherOnShow: true);
  }
}
