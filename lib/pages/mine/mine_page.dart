
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/pages/consultation/instructor_demeanor_page.dart';
import 'package:flutter_first/pages/exit_login_page.dart';
import 'package:flutter_first/pages/home/doctor/history_record.dart';
import 'package:flutter_first/pages/home/home_widgets/course/course_page.dart';
import 'package:flutter_first/pages/mine/Report/reportlist.dart';
import 'package:flutter_first/pages/mine/feedback_page.dart';
import 'package:flutter_first/pages/mine/sport/step_ranking_page.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/my_card.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
//import 'package:todaystep/audioplayers.dart';

class MinePage extends StatefulWidget {


  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

//  AudioPlayer audioPlayer = AudioPlayer();
  int _counter = 0;


  @override
  void initState() {
//    getTodayStep();
  }

//  getTodayStep(){
//    Future.delayed(Duration(seconds: 10),() async{
//      Toast.show('获取步数执行');
//      _counter = await audioPlayer.getTodayStep();
//    });
//
//  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的',
        ),
        centerTitle: true,
        backgroundColor: Colours.bg_green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Container(
              height: 170,
              color: Colours.bg_green,
            ),
//              Positioned(
//                top: 10,
//                left: ScreenUtil().setWidth(47),
//                child: Text('我的',
//                    style: TextStyle(color: Colors.white, fontSize: 18)),
//              ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572862144&di=d3fabea17ef23e6434c8a3499bc74e3e&imgtype=jpg&er=1&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20181003%2F17%2F1538557769-tTlpNrusja.jpg'))),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('张警官',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        Text('189*****111',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                    SizedBox(
                      width: 105,
                    ),
                    InkWell(
                      child: Stack(
                        alignment: FractionalOffset(0.5, 0.5),
                        children: <Widget>[
                          Opacity(
                            opacity: 0.5,
                            child: Container(
                              height: 30,
                              width: 30,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                            ),
                          ),
                          Center(
                            child: Image.asset('assets/images/mine/字母.png',
                                height: 20, width: 20),
                          )
                        ],
                      ),
                      onTap: () {
                        Share.text('我的分享', 'www.baidu.com', 'text/plain');
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Stack(
                      alignment: FractionalOffset(0.5, 0.5),
                      children: <Widget>[
                        Opacity(
                          opacity: 0.5,
                          child: Container(
                            height: 30,
                            width: 30,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                          ),
                        ),
                        Center(
                          child: Image.asset('assets/images/mine/二维码.png',
                              height: 20, width: 20),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '$_counter',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '步数',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Container(
                      width: 1,
                      height: 35,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    InkWell(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '5',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '排名',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        NavigatorUtil.pushPage(context, StepRanking());
                      },
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: MyCard(
                    child: Container(
                      margin: EdgeInsets.only(left: 10,right: 10,top: 18,bottom: 18),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                height: 60,
                                width: 40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/mine/我的收藏.png',
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      '我的收藏',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                NavigatorUtil.pushPage(
                                    context, instructor_demeanor());
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                NavigatorUtil.pushPage(context, PsyCourse());
                              },
                              child: Container(
                                height: 60,
                                width: 40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/mine/我的步数.png',
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      '我的步数',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                height: 60,
                                width: 40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/mine/我的活动.png',
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      '我的活动',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                NavigatorUtil.pushPage(
                                    context, instructor_demeanor());
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                height: 60,
                                width: 40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/mine/消息通知.png',
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      '消息通知',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/体检报告.png',
                            height: 25,
                            color: Color(0xffF76B1C),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            '体检报告',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/箭头.png',
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    NavigatorUtil.pushPage(context, ReportList());
                  },
                ), // 体检报告
                SizedBox(
                  height: 1,
//            child: Container(
//              color: Colours.line,
//            ),
                ),
                FlatButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/健康咨询.png',
                            height: 18,
                            color: Color(0xffF76B1C),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            '我的问诊',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/箭头.png',
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    NavigatorUtil.pushPage(context, HistoryRecord());
                  },
                ), //健康咨询
                SizedBox(
                  height: 1,
//            child: Container(
//              color: Colours.line,
//            ),
                ),

                FlatButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/问卷量表.png',
                            height: 18,
                            color: Color(0xffF76B1C),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            '问卷量表',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/箭头.png',
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {},
                ), //问卷调查
                SizedBox(
                  height: 9,
//            child: Container(
//              color: Colours.line,
//            ),
                ),
                FlatButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/意见建议.png',
                            height: 18,
                            color: Color(0xff0778DE),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            '意见建议',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/箭头.png',
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    NavigatorUtil.pushPage(context, FeedBackPage());
                  },
                ), //意见建议
                SizedBox(
                  height: 1,
//            child: Container(
//              color: Colours.line,
//            ),
                ),
                FlatButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/联系我们.png',
                            height: 18,
                            color: Color(0xff0778DE),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            '联系我们',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/箭头.png',
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    NavigatorUtil.pushWebView(
                        context,
                        'http://49.232.168.124/phms_resource_base/HomePageDetail/contactUs.htm',
                        {'title': '关于“畅享健康”APP'});
                  },
                ), //联系我们
                SizedBox(
                  height: 1,
//            child: Container(
//              color: Colours.line,
//            ),
                ),
                FlatButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/隐私服务.png',
                            height: 18,
                            color: Color(0xff0778DE),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            '隐私服务',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/箭头.png',
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    NavigatorUtil.pushWebView(
                        context,
                        'http://49.232.168.124/phms_resource_base/HomePageDetail/PrivacyPolicy.htm',
                        {'title': '隐私服务'});
                  },
                ), //隐私服务
                SizedBox(
                  height: 1,
//                      child: Container(
//                        color: Colours.line,
//                      ),
                ),
                FlatButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/绑定微信.png',
                            height: 18,
                            color: Color(0xff0778DE),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            '绑定微信',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/箭头.png',
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {},
                ), //绑定微信
                SizedBox(
                  height: 7,
//            child: Container(
//              color: Colours.line,
//            ),
                ),
                FlatButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/系统设置.png',
                            height: 18,
                            color: Color(0xff429321),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            child: Text(
                              '系统设置',
                              style: TextStyle(fontSize: 14),
                            ),
                            onTap: () {
                              NavigatorUtil.pushPage(
                                  context, ExitLoginPage());
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/mine/箭头.png',
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {},
                ), //系统设

              ],
            ),
          ],
        ),
      ),
    );
  }
}
