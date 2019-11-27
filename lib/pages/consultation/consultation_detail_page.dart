import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/article_detail.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/common_dio.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConsultationDetailPage extends StatefulWidget {

  String id;
  ConsultationDetailPage({Key key, @required this.id})
      : super(key: key);
  _ConsultationDetailPageState createState() => _ConsultationDetailPageState();
}

class _ConsultationDetailPageState extends State<ConsultationDetailPage> {
  bool isSupport = false;
  bool isFavor = false;
  bool isShowingDialog = true;
  String token = '';
  String articlUrl = '';
  bool isShowLoading = true;
  ArticleContent articleContent = new ArticleContent();

  @override
  void initState() {
    token = StorageManager.sharedPreferences.getString(Constant.access_Token);
    _getArticleDetail();
    print('token:$token');
  }
  _getArticleDetail(){
    DioUtils.instance.requestNetwork<ArticleContent>(
      Method.get,
      Api.GETARTICLECONTENT,
      queryParameters: {"articleId": widget.id},
      onSuccess: (data) {

        setState(() {
          articleContent = data;
          isShowLoading = false;
          articlUrl = '${articleContent.content}&token=$token';
          print("拼接地址：${articleContent.content}&token=$token");
        });
      },
      onError: (code, msg) {
        setState(() {
        });
      },
    );
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
            offstage: articleContent.canCollect != 'Y',
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
                    CommonRequest.UserReadingLog(articleContent.id,'A', 'SC');
                  } else {
                    CommonRequest.UserReadingLog(articleContent.id,'A', 'QS');
                  }
                });
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Offstage(
            offstage: articleContent.canLike != 'Y',
            child: GestureDetector(
              child: isSupport?Icon(Icons.favorite,
                  color: Colors.redAccent, size: 20):Icon(Icons.favorite_border,
                  color: Colors.white, size: 20),
              onTap: () {
                setState(() {
                  isSupport = !isSupport;
                  if (isSupport) {
                    CommonRequest.UserReadingLog(articleContent.id,'A', 'DZ');
                  } else {
                    CommonRequest.UserReadingLog(articleContent.id,'A', 'QD');
                  }
                });
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Offstage(
            offstage: articleContent.canTransmit != 'Y',
            child: GestureDetector(
              child: Icon(Icons.share, color: Colors.white, size: 20),
              onTap: () async {
                Share.text(
                    '我的分享',
                    '${articleContent.title}:\n${articleContent.content}',
                    'text/plain');
                CommonRequest.UserReadingLog(articleContent.id,"A", 'ZF');
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
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : (articleContent == null)
          ? Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text('暂无数据'),
      )
          :WebView(
        onWebViewCreated: (WebViewController webViewController) {},
        initialUrl: articlUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
