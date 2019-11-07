import 'package:flutter/material.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
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
      appBar: AppBar(
        title: Text('详情'),
        backgroundColor: Color(0xff2CA687),
        centerTitle: true,
      ),
      body: (widget.Detail == null)? LoadingWidget.childWidget()
          : (widget.Detail == null)
          ? Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text('暂无数据'),
      ):WebView(
        initialUrl:widget.Detail,
      ),
    );
  }
}
