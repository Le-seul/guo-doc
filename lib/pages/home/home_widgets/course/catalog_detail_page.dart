import 'package:flutter/material.dart';
import 'package:flutter_first/pages/home/home_widgets/course/bottom_player%20bar.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CatalogDetail extends StatefulWidget {
  String Detail;
  CatalogDetail({
    Key key,
    @required this.Detail,
  }) : super(key: key);
  @override
  _CatalogDetailState createState() => _CatalogDetailState();
}

class _CatalogDetailState extends State<CatalogDetail> {



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                tooltip: '返回上一层',
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  BottomControllerBar.hideBottomControllerBar(context, false);
                }),
            title: Text('详情'),
            backgroundColor: Color(0xff2CA687),
            centerTitle: true,
          ),
          body: WebView(
            initialUrl: widget.Detail,
            javascriptMode: JavascriptMode.unrestricted,
          )),
      onWillPop: () {
        Navigator.pop(context);
        BottomControllerBar.hideBottomControllerBar(context, false);
      },
    );
  }

}
