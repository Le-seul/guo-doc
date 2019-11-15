import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/net/common_dio.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

//主页，显示一个列表
class ConsultationDetailPage extends StatefulWidget {
  ConsulationColumnsInfo consulationColumnsInfo;

  ConsultationDetailPage({Key key, @required this.consulationColumnsInfo})
      : super(key: key);
  _ConsultationDetailPageState createState() => _ConsultationDetailPageState();
}

class _ConsultationDetailPageState extends State<ConsultationDetailPage> {
  bool isSupport = false;
  bool isFavor = false;
  bool isShowingDialog = true;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          '资讯',
          style: new TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[

          GestureDetector(
            child: Icon(
              isFavor ? Icons.star : Icons.star_border,
              color: Colors.black54,
              size: 24,
            ),
            onTap: () {
              setState(() {
                isFavor = !isFavor;
                if (isFavor) {
                  CommonRequest.UserReadingLog(widget.consulationColumnsInfo.id,widget.consulationColumnsInfo.type, 'SC');
                } else {
                  CommonRequest.UserReadingLog(widget.consulationColumnsInfo.id,widget.consulationColumnsInfo.type, 'QS');
                }
              });
            },
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            child: Icon(isSupport ? Icons.favorite : Icons.favorite_border,
                color: Colors.black54, size: 20),
            onTap: () {
              setState(() {
                isSupport = !isSupport;
                if (isSupport) {
                  CommonRequest.UserReadingLog(widget.consulationColumnsInfo.id,widget.consulationColumnsInfo.type, 'DZ');
                } else {
                  CommonRequest.UserReadingLog(widget.consulationColumnsInfo.id,widget.consulationColumnsInfo.type, 'QD');
                }
              });
            },
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            child: Icon(Icons.share, color: Colors.black54, size: 20),
            onTap: () async {
              Share.text(
                  '我的分享',
                  '${widget.consulationColumnsInfo.title}:\n${widget.consulationColumnsInfo.content}',
                  'text/plain');
              CommonRequest.UserReadingLog(widget.consulationColumnsInfo.id,widget.consulationColumnsInfo.type, 'ZF');
            },
          ),

          SizedBox(
            width: 10,
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) {},
        initialUrl: widget.consulationColumnsInfo.content,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
