import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Test0 extends StatelessWidget {
String Url;
  Test0({Key key, @required this.Url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测评简介'),
        centerTitle: true,
      ),
      body: WebView(
          initialUrl:Url,
          javascriptMode:JavascriptMode.unrestricted
      ),
    );
  }
}
