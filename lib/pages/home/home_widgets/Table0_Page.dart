import 'package:flutter/material.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';

class Table0 extends StatefulWidget {
  Table0({Key key}) : super(key: key);

  _Table0State createState() => _Table0State();
}

class _Table0State extends State<Table0> {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(style: BorderStyle.none),
      children: <TableRow>[
        TableRow(children: <Widget>[

          GestureDetector(
            child: Column(
              children: <Widget>[
                loadAssetImage('entry/easy_music.png',height: 50,
                  width: 50,),
                SizedBox(height: 8,),
                Text(
                  '轻松音乐',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10,)
              ],
            ),
            onTap: () {Router.push(context, Router.musicPage, {'num': 0, 'tagId': ""});},
          ),
          GestureDetector(
            child: Column(
              children: <Widget>[
                loadAssetImage('entry/exercise_evaluation.png',height: 50,
                  width: 50,),
                SizedBox(height: 8,),
                Text(
                  '活动参与',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10,)
              ],
            ),
            onTap: () {},
          ),

          GestureDetector(
            child: Column(
              children: <Widget>[
                loadAssetImage('entry/medical_report.png',height: 50,
                  width: 50,),
                SizedBox(height: 8,),
                Text(
                  '体检报告',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10,)
              ],
            ),
            onTap: () {
              Router.pushNoParams(context, Router.reporylist);
            },
          ),
          GestureDetector(
            child: Column(
              children: <Widget>[
                loadAssetImage('entry/medical_consultation.png',height: 50,
                  width: 50,),
                SizedBox(height: 8,),
                Text(
                  '在线问诊',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10,)
              ],
            ),
            onTap: () {},
          ),
          GestureDetector(
            child: Column(
              children: <Widget>[
                loadAssetImage('entry/daily_test.png',height: 50,
                  width: 50,),
                SizedBox(height: 8,),
                Text(
                  '趣味自测',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10,)
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
                loadAssetImage('entry/course_consultation.png',height: 50,
                  width: 50,),
                SizedBox(height: 8,),
                Text(
                  '心理课程',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10,)
              ],
            ),
            onTap: () {Router.pushNoParams(context, Router.curriculum);},
          ),
          GestureDetector(
            child: Column(
              children: <Widget>[
                loadAssetImage('entry/simple_reading.png',height: 50,
                  width: 50,),
                SizedBox(height: 8,),
                Text(
                  '简单共读',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10,)
              ],
            ),
            onTap: () {Router.pushNoParams(context, Router.togethereading);},
          ),
          GestureDetector(
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
