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
  WebViewController _controller;
  double wordsize = 3.0;
  String SizeClass;
  @override
  void initState() {
    //Swichsize = int.parse(StorageManager.sharedPreferences.getDouble(Constant.word_size).toString());
    wordsize = StorageManager.sharedPreferences.getDouble(Constant.word_size);
    switch(wordsize.toInt()){
      case 1: SizeClass = 'size1()';break;
      case 2 : SizeClass = 'size2()';break;
      case 3 : SizeClass = 'size3()';break;
      case 4: SizeClass = 'size4()';break;
      case 5: SizeClass = 'size5()';break;
      case 6 : SizeClass = 'size6()';break;
      case 7 : SizeClass = 'size7()';break;
      default : SizeClass = 'size3()';break;
    };
    print("打印出来${wordsize.toInt()}");
    if(widget.params['redirection'] != null){
      redirectoon = true;
      String token = StorageManager.sharedPreferences.getString(Constant.access_Token);
      htmlUrl = '${Config.apiHost}/api/staticResource.do?getResource&url=/mobilearticleui/index.html' + '&token=' + token+'&commonIp=${Config.apiHost}';
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
          onWebViewCreated: (WebViewController webViewController){
            webViewController.canGoBack();
            _controller = webViewController;
          },
          onPageFinished: (url){
            _controller?.evaluateJavascript(SizeClass)?.then((result){
              print('调用成功');
              print(result);
              setState(() {
              });
            });
          },

        ));

  }


}
