import 'package:flutter/material.dart';


class Table1 extends StatefulWidget {
  Table1({Key key}) : super(key: key);

  _Table1State createState() => _Table1State();
}

class _Table1State extends State<Table1> {
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
                         Image.asset('assets/images/体检报告.png'),
                         Text('体检报告',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){},
                 ),
                 FlatButton(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         Image.asset('assets/images/医疗咨询.png'),
                         Text('医疗咨询',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){},
                 ),
                 FlatButton(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         Image.asset('assets/images/药品库查询.png'),
                         Text('药品库查询',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){},
                 ),
                 FlatButton(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         Image.asset('assets/images/门诊意见建议.png'),
                         Text('门诊意见建议',style: TextStyle(fontSize: 12),)
                       ],
                     ),
                   ),
                   onPressed: (){},)
                ]
              ),

              
            ],
          ) ;
  }
}