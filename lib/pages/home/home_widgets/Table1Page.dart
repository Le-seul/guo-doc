import 'package:flutter/material.dart';


class Table1 extends StatefulWidget {
  Table1({Key key}) : super(key: key);

  _Table1State createState() => _Table1State();
}

class _Table1State extends State<Table1> {
  @override
  Widget build(BuildContext context) {
    return Table(
            border:TableBorder.all(style:BorderStyle.none) ,
            children:<TableRow>[
              TableRow(
                children:<Widget>[
                  GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/images/easy_music.png',height: 50,
                          width: 50,),
                        SizedBox(height: 8,),
                        Text(
                          '体检报告',
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
                        Image.asset('assets/images/exercise_evaluation.png',height: 50,
                          width: 50,),
                        SizedBox(height: 8,),
                        Text(
                          '医疗咨询',
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
                        Image.asset('assets/images/course_consultation.png',height: 50,
                          width: 50,),
                        SizedBox(height: 8,),
                        Text(
                          '药品查询',
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
                        Image.asset('assets/images/medical_consultation.png',height: 50,
                          width: 50,),
                        SizedBox(height: 8,),
                        Text(
                          '门诊意见',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                    onTap: () {},
                  ),
                ]
              ),

              
            ],
          ) ;
  }
}