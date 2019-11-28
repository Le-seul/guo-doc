import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/res/colors.dart';
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
          backgroundColor: Colours.bg_green,
          centerTitle: true,
//          actions: <Widget>[
//            IconButton(
//                icon: Icon(Icons.share),
//                onPressed: (){
//                  Share.text('我的分享', params[TITLE]+'  请参考  '+url, 'text/plain');
//                })
//          ],
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
