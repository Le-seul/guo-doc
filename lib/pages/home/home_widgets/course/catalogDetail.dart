import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CatalogDetail extends StatefulWidget {
  String Detail;
  CatalogDetail({Key key, @required this.Detail, }): super(key: key);
  @override
  _CatalogDetailState createState() => _CatalogDetailState();
}

class _CatalogDetailState extends State<CatalogDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl:widget.Detail,
      ),
    );
  }
}
