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
        elevation: 0.0,
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
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            onWebViewCreated: (WebViewController webViewController) {},
            initialUrl: widget.consulationColumnsInfo.content,
            javascriptMode: JavascriptMode.unrestricted,
          ),
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 1.0,
                  color: Colours.line,
                ),
                Container(
                  height: 40,
                  color: Color(0xFFF6F6F6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon:
                            Icon(Icons.share, color: Colors.black26, size: 20),
                        onPressed: () async {
                          Share.text(
                              '我的分享',
                              '${widget.consulationColumnsInfo.title}:\nhttps://www.baidu.com/index.php?tn=02049043_6_pg',
                              'text/plain');
                        },
                      ),
                      GestureDetector(
                        child: IconButton(
                          icon: Icon(
                            isFavor ? Icons.star : Icons.star_border,
                            size: 24,
                          ),
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
                      GestureDetector(
                        child: IconButton(
                          icon: Icon(
                              isSupport
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 20),
                        ),
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
                    ],
                  ),
                ),
              ],
            ),
            alignment: FractionalOffset.bottomCenter,
          )
        ],
      ),
    );
  }
}
