import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BodyReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        title: Text('体检报告'),
        centerTitle: true,
      ),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController){
          webViewController.canGoBack();
        },
          initialUrl:'http://ygyd.aireading.top/mobile_phy_exam/html/index.html',
          javascriptMode:JavascriptMode.unrestricted
      ),
    );

  }
}
