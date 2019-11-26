import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/article_detail.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/common_dio.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  String token = '';

  @override
  void initState() {
    token = StorageManager.sharedPreferences.getString(Constant.access_Token);
    print('token:$token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '资讯',
        ),
        actions: <Widget>[
          Offstage(
            offstage: widget.consulationColumnsInfo.canCollect != 'Y',
            child: GestureDetector(
              child: isFavor?Icon(
                Icons.star,
                color: Colors.redAccent,
                size: 24,
              ):Icon(
                Icons.star_border,
                color: Colors.white,
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
          ),
          SizedBox(
            width: 10,
          ),
          Offstage(
            offstage: widget.consulationColumnsInfo.canLike != 'Y',
            child: GestureDetector(
              child: isSupport?Icon(Icons.favorite,
                  color: Colors.redAccent, size: 20):Icon(Icons.favorite_border,
                  color: Colors.white, size: 20),
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
          ),
          SizedBox(
            width: 10,
          ),
          Offstage(
            offstage: widget.consulationColumnsInfo.canTransmit != 'Y',
            child: GestureDetector(
              child: Icon(Icons.share, color: Colors.white, size: 20),
              onTap: () async {
                Share.text(
                    '我的分享',
                    '${widget.consulationColumnsInfo.title}:\n${widget.consulationColumnsInfo.content}',
                    'text/plain');
                CommonRequest.UserReadingLog(widget.consulationColumnsInfo.id,widget.consulationColumnsInfo.type, 'ZF');
              },
            ),
          ),

          SizedBox(
            width: 10,
          )
        ],
        centerTitle: true,
        backgroundColor: Color(0xff2CA687),
      ),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) {},
        initialUrl: widget.consulationColumnsInfo.content+'&'+token,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
