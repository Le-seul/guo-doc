import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String url;
  final dynamic params;
  static final String TITLE = 'title';

  WebViewPage(this.url, {Key key, this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(params[TITLE]),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) {},
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      )
    ) ;
  }
}
