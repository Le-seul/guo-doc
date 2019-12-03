import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/chunyu_message.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:flutter_first/bloc/bloc_provider.dart';
import 'package:flutter_first/bloc/chunyu_bloc.dart';
import 'package:flutter_first/db/order_db.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/pages/home/doctor/doctor_chunyu_home_page.dart';
import 'package:flutter_first/pages/home/home_widgets/coreading/coreading_page.dart';
import 'package:flutter_first/pages/home/home_widgets/course/course_page.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/everydaytestpage.dart';
import 'package:flutter_first/pages/home/home_widgets/music_page.dart';
import 'package:flutter_first/pages/home/home_widgets/pstConsult_page.dart';
import 'package:flutter_first/pages/mine/Report/reportlist.dart';
import 'package:flutter_first/pages/service/service_page.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/navigator_util.dart';

class Table0 extends StatefulWidget {
  VoidCallback onPress;
  //constructor
  Table0(this.onPress);

  _Table0State createState() => _Table0State();
}

class _Table0State extends State<Table0> {
  bool offstage = true;
  String count = '';
  int intTuWen = 0;
  int intFastPhone = 0;
  var db = OrderDb();

  @override
  void initState() {
    init();
  }

  init() async {
    List<Map> list = await db.getAllOrder();
//    print("数据库list3:$list");
    List<OrderNum> listNum = List();
    for (Map map in list) {
      listNum.add(OrderNum.fromJson(map));
    }
    for (OrderNum orderNum in listNum) {
      setState(() {
        if (orderNum.location == "chunyuTuwen") {
          intTuWen = int.parse(orderNum.num) + intTuWen;
        } else {
          intFastPhone = int.parse(orderNum.num) + intFastPhone;
        }
      });
    }
    setState(() {
      count = (intTuWen + intFastPhone).toString();
      offstage = (intTuWen == 0 && intFastPhone == 0);
      print("count:$count");
    });
  }

  @override
  Widget build(BuildContext context) {
    final ChunyuPushBloc bloc = BlocProvider.of<ChunyuPushBloc>(context);

    return Table(
      border: TableBorder.all(style: BorderStyle.none),
      children: <TableRow>[
        TableRow(children: <Widget>[
          GestureDetector(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  loadAssetImage(
                    'entry/easy_music.png',
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '轻松音乐',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
            onTap: () {
              NavigatorUtil.pushPage(context, MusicPage(num: 0, tagId: ''));
            },
          ),
          GestureDetector(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                loadAssetImage(
                  'entry/exercise_evaluation.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '活动参与',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
            onTap: () {
              widget.onPress();
            },
          ),
          GestureDetector(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                loadAssetImage(
                  'entry/medical_report.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '体检报告',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
            onTap: () {
              NavigatorUtil.pushPage(context, ReportList());
            },
          ),
          Container(
              child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      loadAssetImage(
                        'entry/medical_consultation.png',
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '在线问诊',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                  onTap: () {
                    NavigatorUtil.pushPage(context, DoctorChunyuHomePage());
                  },
                ),
              ),
              StreamBuilder<ChunyuMessage>(
                stream: bloc.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<ChunyuMessage> snapshot) {
                  return Offstage(
                    offstage: snapshot.hasData?(snapshot.data.fastPhoneNum + snapshot.data.tuwenNum == 0): count == "0"||count == '',
                    child: Container(
                      padding: EdgeInsets.only(right: 2),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 6, right: 6, top: 2, bottom: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              snapshot.hasData
                                  ? (snapshot.data.tuwenNum+snapshot.data.fastPhoneNum).toString()
                                  : count,
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
          GestureDetector(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                loadAssetImage(
                  'entry/daily_test.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '趣味自测',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
            onTap: () {
              NavigatorUtil.pushPage(context, EverydayTest());
            },
          ),
        ]),
        TableRow(children: <Widget>[
          GestureDetector(
            child: Column(
              children: <Widget>[
                loadAssetImage(
                  'entry/course_consultation.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '心理课程',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            onTap: () {
              NavigatorUtil.pushPage(context, PsyCourse());
            },
          ),
          GestureDetector(
            child: Column(
              children: <Widget>[
                loadAssetImage(
                  'entry/simple_reading.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '心理共读',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            onTap: () {
              NavigatorUtil.pushPage(context, SimpleCoreading());
            },
          ),
          GestureDetector(
              child: Column(
                children: <Widget>[
                  loadAssetImage(
                    'entry/psychological_consultation.png',
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '心理咨询',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              onTap: () {
                NavigatorUtil.pushPage(context, PsychologicalConcult());
              }),
          GestureDetector(
            child: Container(),
//            child: Column(
//              children: <Widget>[
//                loadAssetImage('entry/physical_assessment.png',height: 50,
//                  width: 50,),
//                SizedBox(height: 8,),
//                Text(
//                  '身体评估',
//                  style: TextStyle(fontSize: 12),
//                ),
//                SizedBox(height: 10,)
//              ],
//            ),
            onTap: () {},
          ),
          GestureDetector(
            child: Container(),
//            child:  Container(child: Column(
//              children: <Widget>[
//                loadAssetImage('entry/chronic_disease_assessment.png',
//                  height: 50,
//                  width: 50,),
//                SizedBox(height: 8,),
//                Text(
//                  '慢病评估',
//                  style: TextStyle(fontSize: 12),
//                ),
//                SizedBox(height: 10,)
//              ],
//            ),),
//            onTap: () { Router.pushNoParams(context, Router.eating);},
          ),
        ]),
      ],
    );
  }
}
