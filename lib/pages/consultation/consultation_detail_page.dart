import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/article_detail.dart';
import 'package:flutter_first/bean/article_likestatus.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/common_dio.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/sharedialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConsultationDetailPage extends StatefulWidget {

  String id;
  String imgurl;
  ConsultationDetailPage({Key key, @required this.id,@required this.imgurl})
      : super(key: key);
  _ConsultationDetailPageState createState() => _ConsultationDetailPageState();
}

class _ConsultationDetailPageState extends State<ConsultationDetailPage> {
  bool isShowingDialog = true;
  String token = '';
  String articlUrl = '';
  bool isShowLoading = true;
  LikeStatus likeStatus = new LikeStatus();
  ArticleContent articleContent = new ArticleContent();
  WebViewController _controller;
  double wordsize = 3.0;
  String SizeClass;
  @override
  void initState() {
    wordsize = StorageManager.sharedPreferences.getDouble(Constant.word_size);
    switch(wordsize.toInt()){
      case 1: SizeClass = 'size1()';break;
      case 2 : SizeClass = 'size2()';break;
      case 3 : SizeClass = 'size3()';break;
      case 4: SizeClass = 'size4()';break;
      case 5: SizeClass = 'size5()';break;
      case 6 : SizeClass = 'size6()';break;
      case 7 : SizeClass = 'size7()';break;
      default : SizeClass = 'size3()';break;
    };
    token = StorageManager.sharedPreferences.getString(Constant.access_Token);
    _getArticleDetail();
    _getLikeStatus();
    print('token:$token');
  }

  _getLikeStatus(){
    DioUtils.instance.requestNetwork<LikeStatus>(
      Method.get,
      Api.GRTLIKESTATUS,
      queryParameters: {"articleId": widget.id},
      onSuccess: (data) {
        setState(() {
          likeStatus = data;
          print("获取点赞状态成功！");
        });
      },
      onError: (code, msg) {
        setState(() {
          print("获取点赞状态失败！");
        });
      },
    );
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
              child: likeStatus.collectStatus == 1?Icon(
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
                  if (likeStatus.collectStatus == 1) {

                    _userReadingLog(articleContent.id,'A', 'QS');
                  } else {

                    _userReadingLog(articleContent.id,'A', 'SC');
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
              child:
              Container(
                height: 18,
                width: 18,
                child: Image.asset(
                  'assets/images/consultation/点赞.png',
                  color: likeStatus.likeStatus == 1?Colors.redAccent:Colors.white,
                ),
              ),
              onTap: () {
                setState(() {
                  if(likeStatus.likeStatus == 1){

                    _userReadingLog(articleContent.id,'A', 'QD');
                  }else{

                    _userReadingLog(articleContent.id,'A', 'DZ');
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
              onTap: () {
                showDialog<Null>(
                    context: context,
                    builder: (BuildContext context) {
                      return ShareDialog(title: articleContent.title,description: articleContent.description,webPage: articleContent.content,thumbnail: widget.imgurl,);
                    }
                );
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
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageFinished: (url){
          _controller?.evaluateJavascript(SizeClass)?.then((result){
            print('调用成功');
            print(result);
            setState(() {
            });
          });
        },
        initialUrl: articlUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
 _userReadingLog(String resourceId, String type, String action) {
    DioUtils.instance.requestNetwork<String>(Method.post, Api.USEREADINGLOG,
        queryParameters: {
          'resourceId': resourceId,
          'type': type,
          'action': action,
        }, onSuccess: (data) {
          if (action == 'DZ') {
            Toast.show('点赞成功！');
          } else if (action == 'QD') {
            Toast.show('取消点赞！');
          } else if (action == 'SC') {
            Toast.show('收藏成功！');
          } else if (action == 'QS') {
            Toast.show('取消收藏！');
          }
          _getLikeStatus();
          print('上传$action成功!');
        }, onError: (code, msg) {
          if (action == 'DZ') {
            Toast.show('点赞失败！');
          } else if (action == 'QD') {
            Toast.show('取消点赞失败！');
          } else if (action == 'SC') {
            Toast.show('收藏失败！');
          } else if (action == 'QS') {
            Toast.show('取消收藏失败！');
          }
          print('上传$action失败!');
        });
  }
}
