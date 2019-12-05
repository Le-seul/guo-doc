import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/config.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Test0 extends StatelessWidget {
String Url;
String token;
String baseurl;
void initState(){

  token = StorageManager.sharedPreferences.getString(Constant.access_Token);
  baseurl = Config.apiHost;

}
  Test0({Key key, @required this.Url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测评简介'),
        centerTitle: true,
      ),
      body: WebView(
          initialUrl:'$baseurl/api/staticResource.do?getResource&url=mobile_survy_ui/index.html&token=$token&questionnaireId=$Url',
          javascriptMode:JavascriptMode.unrestricted
      ),
    );
  }
}

