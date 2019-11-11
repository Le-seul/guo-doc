import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:flutter_first/db/order_db.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';

class Table0 extends StatefulWidget {
  Table0({Key key}) : super(key: key);

  _Table0State createState() => _Table0State();
}

class _Table0State extends State<Table0> {
  bool offstage = true;
  StreamSubscription exitLogin;
  String count = '';
  var db = OrderDb();

  @override
  void initState() {
    init();
    exitLogin = eventBus.on<refreshNum>().listen((event) {
      setState(() {
//        print('数据库evenBus');
        init();
      });
    });
  }

  @override
  void deactivate() {
    init();
  }

  init() async{

    List<Map> list= await db.getAllOrder();
//    print("数据库list3:$list");
    List<OrderNum> listNum = List();
    for(Map map in list){
      listNum.add(OrderNum.fromJson(map));
    }
    int intTuWen = 0;
    int intFastPhone = 0;
    for(OrderNum orderNum in listNum){

      setState(() {
        if(orderNum.location == "chunyuTuwen"){

          intTuWen = int.parse(orderNum.num)+intTuWen;

        }else{
          intFastPhone += int.parse(orderNum.num);
        }
      });
    }
    setState(() {
      count = (intTuWen+intFastPhone).toString();
      offstage = (intTuWen == 0 && intFastPhone == 0);
      print("count:$count");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(style: BorderStyle.none),
      children: <TableRow>[
        TableRow(
            children: <Widget>[
          GestureDetector(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5,),
                  loadAssetImage(
                    'entry/easy_music.png',
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '轻松音乐',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            onTap: () {
              Router.push(context, Router.musicPage, {'num': 0, 'tagId': ""});
            },
          ),
          GestureDetector(
            child: Column(
              children: <Widget>[
                SizedBox(height: 5,),
                loadAssetImage(
                  'entry/exercise_evaluation.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '活动参与',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            onTap: () {
              Router.pushNoParams(context, Router.servicePage);
            },
          ),
          GestureDetector(
            child: Column(
              children: <Widget>[
                SizedBox(height: 5,),
                loadAssetImage(
                  'entry/medical_report.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '体检报告',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            onTap: () {
              Router.pushNoParams(context, Router.reporylist);
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
                      SizedBox(height: 5,),
                      loadAssetImage(
                        'entry/medical_consultation.png',
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '在线问诊',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  onTap: () {
                    Router.pushNoParams(context, Router.doctorChunyuHomePage);
                  },
                ),
              ),
              Offstage(
                offstage: offstage,
                child: Container(
                  padding: EdgeInsets.only(right: 2),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        count,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
          GestureDetector(
            child: Column(
              children: <Widget>[
                SizedBox(height: 5,),
                loadAssetImage(
                  'entry/daily_test.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '趣味自测',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            onTap: () {
              Router.pushNoParams(context, Router.everydaytest);
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
                  height: 8,
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
              Router.pushNoParams(context, Router.curriculum);
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
                  height: 8,
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
              Router.pushNoParams(context, Router.togethereading);
            },
          ),
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
          GestureDetector(
            child: Container(),
//            child: Column(
//              children: <Widget>[
//                loadAssetImage('entry/psychological_consultation.png',height: 50,
//                  width: 50,),
//                SizedBox(height: 8,),
//                Text(
//                  '心理咨询',
//                  style: TextStyle(fontSize: 12),
//                ),
//                SizedBox(height: 10,)
//              ],
//            ),
//            onTap: () {Router.pushNoParams(context, Router.psychologicalConcult);},
          ),
        ]),
      ],
    );
  }
}
