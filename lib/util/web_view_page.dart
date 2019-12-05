import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/config.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final dynamic params;
  static final String TITLE = 'title';
  WebViewPage(this.url, {Key key, this.params}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  String htmlUrl = '';
  bool redirectoon = false;

  @override
  void initState() {

    if(widget.params['redirection'] != null){
      redirectoon = true;
      String token = StorageManager.sharedPreferences.getString(Constant.access_Token);
      htmlUrl = '${Config.apiHost}/api/staticResource.do?getResource&url=mobile-phy-exam-report-ui/html/index.html' + '&token=' + token;
      if(widget.params['year'] != null){
        htmlUrl = htmlUrl + '&year=${widget.params['year']}';
      }
      print("htmlUrl:$htmlUrl");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.params[WebViewPage.TITLE]),
          backgroundColor: Colours.bg_green,
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: redirectoon?htmlUrl:widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }


}
