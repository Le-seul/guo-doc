import 'package:flutter/material.dart';
import 'package:flutter_first/bean/activity_detail_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/consultation_detail_page.dart';
import 'package:flutter_first/pages/consultation/consutation_list.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/daytest.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/first.dart';
import 'package:flutter_first/util/dialog.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ServiceActivityPage extends StatefulWidget {
  String activityId;
  @override
  _ServiceActivityPageState createState() => _ServiceActivityPageState();

  ServiceActivityPage({Key key, @required this.activityId}) : super(key: key);
}

class _ServiceActivityPageState extends State<ServiceActivityPage> {
  ActivityDetail activityDetail;
  bool isShowLoading = true;
  String signUpText = '报名';

  @override
  void initState() {
    _getActivityDetail();
  }


  @override
  void deactivate() {
    _getActivityDetail();
  }

  _getActivityDetail() {
    DioUtils.instance.requestNetwork<ActivityDetail>(
      Method.get,
      Api.GETACTIVITIEDETAIL,
      queryParameters: {"activityId": widget.activityId},
      onSuccess: (data) {
        setState(() {
          isShowLoading = false;
          activityDetail = data;
          if (activityDetail.isSignUp == 'Y') {
            signUpText = '已报名';
          }
          print('活动内容获取成功');
        });
      },
      onError: (code, msg) {
        setState(() {
          isShowLoading = false;
          Toast.show('请求失败！');
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
          backgroundColor: Color(0xff2CA687),
          title: Text(
            '活动',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: Container(
            child: isShowLoading
                ? LoadingWidget.childWidget()
                : (activityDetail == null)
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text('暂无数据'),
                      )
                    : Container(
                        width: double.infinity,
                        child: ListView(
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Container(
                                width: double.infinity,
                                child: AspectRatio(
                                  aspectRatio: 375 / 168,
                                  child: Image.network(
                                    activityDetail.cover,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '活动时间:',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          activityDetail.startTime.substring(0,activityDetail.startTime.length-3),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '活动地点:',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Text(
                                            activityDetail.location ?? "无",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '报名人数:',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          '${activityDetail.signInCount}人',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(
                                  Icons.person_outline,
                                  color: Colors.black54,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${activityDetail.signInCount}人已报名",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Offstage(
                              offstage: activityDetail.childActivity==null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                    child: Container(
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 15),
                                      child: Text(
                                        '相关活动',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                  Container(
                                    height: 120,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: false,
                                      itemCount:activityDetail.childActivity == null ?0:activityDetail.childActivity.length,
                                      itemBuilder: (context, index) =>
                                          _childItem(index),
                                    ),
                                  ),
                                ],
                              ),
                            ),
//                            Container(height: 1100,
//                              child: WebView(
//                                initialUrl:
//                                    'http://49.232.168.124/phms_resource_base/HomePageDetail/HomePage02.htm',
//                                javascriptMode: JavascriptMode.unrestricted,
//                              ),
//                            ),
                            SizedBox(
                              height: 20,
                              child: Container(
                                color: Colors.grey[200],
                              ),
                            ),
                            Offstage(
                              offstage: activityDetail.articleList.isEmpty,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 15, left: 15, right: 15),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                          '相关资讯',
                                          style: TextStyle(fontSize: 18),
                                        )),
//                                        GestureDetector(
//                                          onTap: (){
//                                            NavigatorUtil.pushPage(context, ConsutationList());
//                                          },
//                                          child: Text(
//                                            '更多',
//                                            style:
//                                                TextStyle(color: Colors.black54),
//                                          ),
//                                        ),
//                                        Icon(
//                                          Icons.chevron_right,
//                                          color: Colors.black54,
//                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          activityDetail.articleList.length,
                                      itemBuilder: (context, index) =>
                                          _buildItem1(index),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Offstage(
                              offstage:
                                  activityDetail.questionnaireList.isEmpty&&activityDetail.questionnaireCollectionList.isEmpty,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 15, left: 15, right: 15),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                          '调查问卷',
                                          style: TextStyle(fontSize: 18),
                                        )),
//                                        GestureDetector(
//                                          onTap: (){
//                                            NavigatorUtil.pushPage(context, DayTest());
//                                          },
//                                          child: Text(
//                                            '更多',
//                                            style:
//                                                TextStyle(color: Colors.black54),
//                                          ),
//                                        ),
//                                        Icon(
//                                          Icons.chevron_right,
//                                          color: Colors.black54,
//                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: activityDetail
                                          .questionnaireList.length,
                                      itemBuilder: (context, index) =>
                                          _buildItem(index),
                                    ),
                                  ),
                                  Container(
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: activityDetail
                                          .questionnaireCollectionList.length,
                                      itemBuilder: (context, index) =>
                                          _buildItem2(activityDetail
                                              .questionnaireCollectionList[index]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
//                            Container(
//                              color: Colors.grey[200],
//                              margin:
//                                  EdgeInsets.only(left: 10, right: 10, top: 10),
//                              padding: EdgeInsets.only(
//                                  left: 10, right: 30, top: 10, bottom: 10),
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceBetween,
//                                children: <Widget>[
//                                  Text('活动满意度调查问卷，点击前往'),
//                                  Icon(
//                                    Icons.dashboard,
//                                    color: Colors.green,
//                                  )
//                                ],
//                              ),
//                            ),
                            Container(
                              padding: EdgeInsets.only(left: 30.0, right: 30.0),
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              child: FlatButton(
                                onPressed: () {
                                  if (signUpText == '报名') {
                                    NavigatorUtil.pushWebView(
                                        context,
                                        'http://49.232.168.124/phms_resource_base/mobile_survy_ui/index6.html',
                                        {"title": "调查问卷"});
                                    signUpActivity();
                                  }
                                },
                                color: Colors.orange,
                                child: Text(
                                  signUpText,
                                  style: TextStyle(color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            )
                          ],
                        ),
                      ),
          ),
        ));
  }

  _childItem(int index) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pushPage(
            context,
            ServiceActivityPage(
                activityId: activityDetail.childActivity[index].id));
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 8),
        child: Column(
          children: <Widget>[
            Image.network(
              activityDetail.childActivity[index].cover,
              height: 80,
              width: 120,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                width: 120,
                child: Text(
                  activityDetail.childActivity[index].name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))
          ],
        ),
      ),
    );
  }

  signUpActivity() {
    DioUtils.instance.requestNetwork<String>(
      Method.post,
      Api.SIGNUPACTIVITY,
      queryParameters: {"activityId": widget.activityId},
      onSuccess: (data) {
        setState(() {
//          showDialog<Null>(
//              context: context, //BuildContext对象
//              barrierDismissible: false,
//              builder: (BuildContext context) {
//                return LoadingDialog();
//              });
          signUpText = '已报名';
        });
        print('活动报名成功');
      },
      onError: (code, msg) {
        setState(() {
          print('活动报名失败');
        });
      },
    );
  }

  _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        if (activityDetail.questionnaireList[index].isFinished != "Y") {
          NavigatorUtil.pushPage(
              context,
              Test0(
                questionnaireId: activityDetail.questionnaireList[index].id,
              ));
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 10,top: 10, left: 15, right: 15),
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
//            Container(
//              height: 1,
//              color: Colors.grey[200],
//            ),
//            SizedBox(
//              height: 20,
//            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        activityDetail.questionnaireList[index].cover,
                        height: 80,
                        width: 120,
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            activityDetail.questionnaireList[index].title,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          activityDetail.questionnaireList[index].isFinished == "Y"?'已完成':'',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  _buildItem2(QuestionnaireCollectionList questionnaireCollectionList) {
    String ids = '';
    bool isFinished = true;
    for(QuestionnaireChildList questionnaireChildList in questionnaireCollectionList.questionnaireList){
      if(questionnaireChildList.isFinished == "N"){
        isFinished = false;
      }
      ids = (ids + questionnaireChildList.id + ".");

    }
    ids = ids.substring(0,ids.length-1);
    print('活动集id:$ids');
    return GestureDetector(
      onTap: () {
        if (!isFinished) {
          NavigatorUtil.pushPage(
              context,
              Test0(
                questionnaireId: ids,
              ));
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 10,top: 10, left: 15, right: 15),
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
//            Container(
//              height: 1,
//              color: Colors.grey[200],
//            ),
//            SizedBox(
//              height: 20,
//            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        questionnaireCollectionList.cover,
                        height: 80,
                        width: 120,
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            questionnaireCollectionList.name,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          isFinished?'已完成':'',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  _buildItem1(int index) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pushPage(
            context,
            ConsultationDetailPage(
              id: activityDetail.articleList[index].id,
              imgurl:activityDetail.articleList[index].cover,
            ));
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
//            Container(
//              height: 1,
//              color: Colors.grey[200],
//            ),
//            SizedBox(
//              height: 20,
//            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        activityDetail.articleList[index].cover,
                        height: 80,
                        width: 120,
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    activityDetail.articleList[index].title,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
