import 'package:flutter/cupertino.dart';

class NavigatorUtil {
  static void pushPage(
    BuildContext context,
    Widget page,
  ) {
    if (context == null || page == null) return;
    Navigator.push(
        context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }

  static void pushReplacementNamed(
    BuildContext context,
    Widget page,
  ) {
    Navigator.pushReplacement(
        context, CupertinoPageRoute<void>(builder: (context) => page));
  }

  static void pushWebView(
      BuildContext context,
      Widget page,
      ) {
    Navigator.pushReplacement(
        context, CupertinoPageRoute<void>(builder: (context) => page));
  }

}
