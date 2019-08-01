import 'package:flutter/material.dart';
import 'package:flutter_first/util/router.dart';




class Table0 extends StatefulWidget {
  Table0({Key key}) : super(key: key);

  _Table0State createState() => _Table0State();
}

class _Table0State extends State<Table0> {
  @override
  Widget build(BuildContext context) {
    return Table(
            columnWidths: <int,TableColumnWidth>{
              0:FixedColumnWidth(47),           
              1:FixedColumnWidth(47),
              2:FixedColumnWidth(47),
              3:FixedColumnWidth(47),
            },
            border:TableBorder.all(style:BorderStyle.none) ,
            children:<TableRow>[
              TableRow(
                children:<Widget>[
                  FlatButton(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         Image.asset('assets/images/慢病评估.png'),
                         Text('慢病评估',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){
                     Router.pushNoParams(context, Router.eating);
                   },
                 ),
                 FlatButton(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         Image.asset('assets/images/膳食评估.png'),
                         Text('膳食评估',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){},
                 ),
                 FlatButton(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         Image.asset('assets/images/运动评估.png'),
                         Text('运动评估',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){},
                 ),
                 FlatButton(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         Image.asset('assets/images/身体状况评估.png'),
                         Text('身体状况评估',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){},
                 ),
                  
                ]
              ),
              TableRow(
                children:<Widget>[
                  FlatButton(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         Image.asset('assets/images/每日一测.png'),
                         Text('每日一测',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){},
                 ),
                 FlatButton(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         Image.asset('assets/images/心理咨询.png'),
                         Text('心理咨询',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){
                    Router.pushNoParams(context, Router.psychologicalConcult);
                   },
                 ),
                 FlatButton(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         Image.asset('assets/images/课程.png'),
                         Text('课程',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){},
                 ),
                 FlatButton(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         Image.asset('assets/images/简单共读.png'),
                         Text('简单共读',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){},
                 ),
                  
                ]
              ),
              
            ],
          ) ;
  }
}