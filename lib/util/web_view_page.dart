import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String url;
  final dynamic params;
  static final String TITLE = 'title';
  WebViewController _webViewController;
  WebViewPage(this.url, {Key key, this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Future<bool> canGoBack = _webViewController.canGoBack();
          canGoBack.then((str) {
            if (str) {
              _webViewController.goBack();
            } else {
              Navigator.of(context).pop();
            }
          });
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(params[TITLE]),
              backgroundColor: Color(0xff2CA687),
              centerTitle: true,
            ),
            body: WebView(
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
              },
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
            )));
  }
}
