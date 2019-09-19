import 'package:flutter/material.dart';
import 'package:flutter_first/util/image_utils.dart';


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
                        loadAssetImage('entry/drug_inquiry.png',height: 50,
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
                        loadAssetImage('entry/outpatient_advice.png',height: 50,
                          width: 50,),
                        SizedBox(height: 8,),
                        Text(
                          '门诊建议',
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