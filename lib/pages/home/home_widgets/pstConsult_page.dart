import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/pages/home/home_widgets/VideoPlayer_Page.dart';
import 'package:flutter_first/util/dialog.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/util/serviceLocator.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/tel_service.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/search.dart';

class PsychologicalConcult extends StatefulWidget {
  @override
  _PsychologicalConcultState createState() => _PsychologicalConcultState();
}

class _PsychologicalConcultState extends State<PsychologicalConcult> {
  final TelAndSmsService _service = locator<TelAndSmsService>();
  String title = '心理咨询热线须知';
  String content = '''        感谢您对于心理咨询热线的信任与支持！当您开始使用热线咨询服务时，我们可能会对您的个人信息进行收集及研究，请您仔细阅读《心理咨询热线隐私条款》并确定了解我们对您个人信息的处理规则。
         如果您同意《隐私条款》请点击“同意”开始使用心理咨询热线，我们将尽全力保护您的个人信息及合法权益，再次感谢您的信任。''';

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1)).then((value) {
      bool isAree = StorageManager.sharedPreferences.getBool(Constant.psychologicalIsAgree);
      if(isAree == null||isAree == false){
        ShowClauseDialog.showMyMaterialDialog(context,title,content,'psychological');
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('心理咨询'),
          centerTitle: true,
        ),
        body: Container(
          color: Color(0xFFF5F5F5),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                child: SearchTextFieldWidget(
                  isborder: false,
                  controller: TextEditingController(),
                  hintText: '搜索你感兴趣的内容/咨询师',
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  onTab: () {},
                ),
              ),
              VideoPlayer(),
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '超越自我，摆脱讨好与妥协',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
              Container(
                color: Color(0xfff5f5f5),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: MyCard(
                        borderRadius: 3.0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '为什么',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  loadAssetImage('psychological/why.png',
                                      height: 20, width: 20),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '要进行心理咨询',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: MyCard(
                        borderRadius: 3.0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '如何进行',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  loadAssetImage('psychological/search1.png',
                                      height: 20, width: 20),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '第一次心理咨询',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: MyCard(
                        borderRadius: 3.0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '心理咨询',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  loadAssetImage('psychological/message.png',
                                      height: 20, width: 20),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '服务条数',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 25),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        loadAssetImage('psychological/application.png',
                            height: 38, width: 38),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        loadAssetImage('psychological/audit.png',
                            height: 38, width: 38),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        loadAssetImage('psychological/communication.png',
                            height: 38, width: 38),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        loadAssetImage('psychological/feedback.png',
                            height: 38, width: 38),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/psychological/rectangle_dark.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: 15, top: 3, right: 15, bottom: 3),
                          child: Text(
                            '申请',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Color(0xFF5C79C3),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/psychological/rectangle_light.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: 15, top: 3, right: 15, bottom: 3),
                          child: Text(
                            '审核',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Color(0xffDAD9E6),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 15, top: 3, right: 15, bottom: 3),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/psychological/rectangle_light.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Text(
                            '沟通',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Color(0xffDAD9E6),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 15, top: 3, right: 15, bottom: 3),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/psychological/rectangle_light.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Text(
                            '反馈',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xfff5f5f5),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        loadAssetImage('psychological/diamond.png',
                            height: 12, width: 12),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '服务说明',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFF999999)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        loadAssetImage('psychological/diamond.png',
                            height: 12, width: 12),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 1,
                      color: Color(0xFFD5D5D5),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      '电话咨询是由市局心理服务中心外聘的专业心理咨询师为您解答，服务时间为工作日：19:00-21:00。',
                      strutStyle:
                          StrutStyle(forceStrutHeight: true, height: 1.5),
                      style: TextStyle(color: Color(0xFF999999)),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        NavigatorUtil.pushWebView(
                            context,
                            'http://www.aireading.club/phms_resource_base/HomePageDetail/psyPrivacyPolicy.htm',
                            {'title': '心理热线服务隐私政策'});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          loadAssetImage('psychological/exclamation.png',
                              height: 14, width: 14),
                          SizedBox(width:3,),
                          Text('请遵守',style: TextStyle(color: Color(0xFF999999),fontSize: 12)),
                          Text('心理热线服务隐私政策',style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 65,
              )
            ],
          ),
        ),
        resizeToAvoidBottomPadding: false,
        bottomSheet: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
//                    Router.pushNoParams(
//                        context, Router.relativesInformationPage);
                  },
                  child: Container(
                      color: Color(0xFFD5D5D5),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          loadAssetImage('psychological/face_consultation.png',
                              height: 18, width: 18),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '预约面咨',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    _service.call('65260001');
                  },
                  child: Container(
                      color: Color(0xFFF6A744),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          loadAssetImage('psychological/phone_consultation.png',
                              height: 18, width: 18),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '电话咨询',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
