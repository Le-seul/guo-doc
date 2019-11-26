import 'package:flutter/material.dart';
import 'package:flutter_first/pages/home/home_widgets/VideoPlayer_Page.dart';
import 'package:flutter_first/util/dialog.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/search.dart';

class PsychologicalConcult extends StatefulWidget {
  @override
  _PsychologicalConcultState createState() => _PsychologicalConcultState();
}

class _PsychologicalConcultState extends State<PsychologicalConcult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('心理咨询'),
          centerTitle: true,
        ),
        body: Container(
          color: Color(0xFFEEEEEE),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                child: SearchTextFieldWidget(
                  isborder: false,
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

                color: Color(0xFFEEEEEE),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: MyCard(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('为什么',style: TextStyle(fontSize: 12),),
                                  CircleAvatar(
                                      backgroundColor: Color(0xFF9AE5E1),
                                      maxRadius: 10,
                                      child: Text('?',style: TextStyle(color: Colors.white),)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text('要进行心理咨询',style: TextStyle(fontSize: 12),),
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
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('如何进行',style: TextStyle(fontSize: 12),),
                                  CircleAvatar(
                                      backgroundColor: Color(0xFFFBB57D),
                                      maxRadius: 10,
                                      child: Icon(
                                        Icons.search,
                                        size: 15,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text('第一次心理咨询',style: TextStyle(fontSize: 12),),
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
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('心理咨询',style: TextStyle(fontSize: 12),),
                                  CircleAvatar(
                                      backgroundColor: Color(0xFF9CC4EB),
                                      maxRadius: 10,
                                      child: Icon(
                                        Icons.description,
                                        size: 12,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text('服务条数',style: TextStyle(fontSize: 12),),
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
                    EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: CircleAvatar(
                                backgroundColor: Color(0xffFBF3E7),
                                maxRadius: 20,
                                child: Icon(
                                  Icons.create,
                                  color: Colors.blue[200],
                                ))),
                        Expanded(
                            flex: 1,
                            child: CircleAvatar(
                                backgroundColor: Colors.blue[100],
                                maxRadius: 20,
                                child: Icon(
                                  Icons.perm_identity,
                                  color: Colors.blue[200],
                                ))),
                        Expanded(
                            flex: 1,
                            child: CircleAvatar(
                                backgroundColor: Colors.orange[100],
                                maxRadius: 20,
                                child: Icon(
                                  Icons.mail_outline,
                                  color: Colors.blue[200],
                                ))),
                        Expanded(
                            flex: 1,
                            child: CircleAvatar(
                                backgroundColor: Color(0xffD6F1F0),
                                maxRadius: 20,
                                child: Icon(
                                  Icons.description,
                                  color: Colors.blue[200],
                                ))),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 15,top: 3,right: 15,bottom: 3),
                          color: Color(0xFF5C79C3),
                          child: Text('申请'),
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Color(0xFF5C79C3),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15,top: 3,right: 15,bottom: 3),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0,color: Colors.black26),
                            ),
                          child: Text('审核'),
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Colors.black26,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15,top: 3,right: 15,bottom: 3),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0,color: Colors.black26),
                          ),
                          child: Text('沟通'),
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Colors.black26,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15,top: 3,right: 15,bottom: 3),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0,color: Colors.black26),
                          ),
                          child: Text('反馈'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xFFEEEEEE),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '服务说明',
                      style: TextStyle(fontSize: 18, color: Color(0xFF999999)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 1,
                      color: Color(0xFFD5D5D5),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '各科咨询服务时间为9:00-21:00 服务时长为十分钟。心理咨询是由市局心理服务中心外聘的专业心理咨询师为您解答，服务时间为工作日10:00-21:00',
                      strutStyle:
                          StrutStyle(forceStrutHeight: true, height: 1.8),
                      style: TextStyle(color: Color(0xFF999999)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 60,
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
                child: Container(
                    color: Color(0xFFD5D5D5),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.headset_mic,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '预约面咨',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    color: Color(0xFFF6A744),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.phone_in_talk,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '电话咨询',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
