import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/bloc/bloc_provider.dart';


import 'package:flutter_first/bloc/chunyu_bloc.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/data/global_user_data.dart';
import 'package:flutter_first/event/init_data.dart';
import 'package:flutter_first/music/lryic.dart';
import 'package:flutter_first/music/page_playing.dart';
import 'package:flutter_first/music/player.dart';
import 'package:flutter_first/pages/container_page.dart';
import 'package:flutter_first/pages/login_page.dart';
import 'package:flutter_first/util/serviceLocator.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'pages/exit_login_page.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
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
  GlobalUserData globalUserData = GlobalUserData();

  final SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
//  StreamSubscription exitLogin;
  @override
  void initState()  {
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
    return DataProviderWidget(
      data: globalUserData,
      child: OKToast(
          child: ScopedModel<PlayingLyric>(
              model: model,
              child: Quiet(
                child: BlocProvider<ChunyuPushBloc>(
                  bloc: ChunyuPushBloc(),
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
                    title: '畅享健康',
                    //debugShowCheckedModeBanner: false,
                    home: Scaffold(
                      body: InitData(
                        child: Center(
                          child: (token == null || token == '')
                              ? LoginPage()
                              : ContainerPage(),
                        ),
                      ),
                    ),
                    theme: new ThemeData(
                      appBarTheme:AppBarTheme(color: Color(0xff2CA687)),
                      platform: TargetPlatform.iOS,
                    ),
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
