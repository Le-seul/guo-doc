import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
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
            child: Icon(Icons.share, color: Colors.black54, size: 20),
            onTap: () async {
              Share.text(
                  '我的分享',
                  '${widget.consulationColumnsInfo.title}:\nhttps://www.baidu.com/index.php?tn=02049043_6_pg',
                  'text/plain');
            },
          ),
          SizedBox(
            width: 10,
          ),
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
                  Toast.show('收藏成功！');
                } else {
                  Toast.show('取消收藏！');
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
                  Toast.show('点赞成功！');
                } else {
                  Toast.show('取消点赞！');
                }
              });
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
