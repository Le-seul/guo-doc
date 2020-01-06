import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/config.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Test0 extends StatefulWidget {

String questionnaireId;
  Test0({Key key,@required this.questionnaireId})
      : super(key: key);

  @override
  _Test0State createState() => _Test0State();
}

class _Test0State extends State<Test0> {
String token;
String htmlUrl;
String baseurl;


@override
void initState() {
  token = StorageManager.sharedPreferences.getString(Constant.access_Token);
  baseurl = Config.apiHost;
  htmlUrl = '${baseurl}/api/staticResource.do?getResource&url=mobile_survy_ui/index2.html&token=$token&questionnaireIds=${widget.questionnaireId}&commonIp=${baseurl}';
  print('htmlUrl:$htmlUrl');
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测评简介'),
        centerTitle: true,
      ),
      body: WebView(
          initialUrl:htmlUrl,
          javascriptMode:JavascriptMode.unrestricted
      ),
    );
  }
}

