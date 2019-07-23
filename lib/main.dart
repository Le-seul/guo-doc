
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'pages/good_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp(
          //定义路由
          routes: {
            //Map<String, WidgetBuilder>
            "/myapp" : (context) => new MyApp(),
            "/splash": (context) => new SplashPage(),
            "/login": (context) => new LoginPage(),
            "/home": (context) => new HomePage(),
            "/detail": (context) => new DetailPage(),
            "/goodList": (context) => new GoodListPage(),
          },
          //没有路由可以进行匹配的时候
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
                child: new SplashPage()
            ),
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
