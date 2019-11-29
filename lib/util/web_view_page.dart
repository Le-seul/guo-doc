import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
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
  bool isHtml = false;

  @override
  void initState() {
    isHtml = widget.url.contains('.html');

    if(isHtml){
      String token = StorageManager.sharedPreferences.getString(Constant.access_Token);
      String path = widget.url.split('/phms_resource_base/')[1];
      htmlUrl = 'https://www.aireading.club/jeecg/api/staticResource.do?redirect&url=' + path + '&token=' + token;
      print('htmlUrl:$htmlUrl');
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
          initialUrl: isHtml?htmlUrl:widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }


}
