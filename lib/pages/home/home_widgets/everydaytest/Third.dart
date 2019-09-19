import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Test2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测评简介'),
        centerTitle: true,
      ),
      body: WebView(
          initialUrl:'http://ygyd.aireading.top/mobile_survy/index.html?tdsourcetag=s_pcqq_aiomsg',
          javascriptMode:JavascriptMode.unrestricted
      ),
    );
  }
}
