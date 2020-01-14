import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BodyReport extends StatefulWidget {


  @override
  _BodyReportState createState() => _BodyReportState();
}

class _BodyReportState extends State<BodyReport> {
  double Wordsize = 3;
  int Swichsize;
  String SizeClass ='';
  WebViewController _controller;
  @override
  void initState() {
    Wordsize =  StorageManager.sharedPreferences.getDouble(Constant.word_size);
    Swichsize = int.parse(Swichsize.toString());
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('体检报告'),
            centerTitle: true,
            backgroundColor: Colours.bg_green,
            actions: <Widget>[
              FlatButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  await _controller?.evaluateJavascript('size1')?.then((result){
//                    setState(() {
//                    });
                  });
                },
              )
            ],
          ),
          body: WebView(
            onWebViewCreated: (WebViewController webViewController){
              webViewController.canGoBack();
              _controller = webViewController;
              switch(Swichsize){
                case 1 : SizeClass = 'size1';break;
                case 2 : SizeClass = 'size2';break;
                case 3 : SizeClass = 'size3';break;
                case 4 : SizeClass = 'size4';break;
                case 5 : SizeClass = 'size5';break;
                case 6 : SizeClass = 'size6';break;
                case 7 : SizeClass = 'size7';break;
                default : SizeClass = 'size3';break;
              }

            },

            initialUrl:'http://ygyd.aireading.top/mobile_phy_exam/html/index.html',
            javascriptMode:JavascriptMode.unrestricted,
          ),
        ));
  }
}

