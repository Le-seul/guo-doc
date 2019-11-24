import 'package:flutter/material.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';


class ReportList extends StatefulWidget {
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('体检报告'),
        centerTitle: true,
        backgroundColor: Colours.bg_green,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 5  ,),
          InkWell(
            child: Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset('assets/images/tijian.png'),
                  Text('2014-07-17 体检报告           ',style: TextStyle(fontSize: 17),),
                  Icon(Icons.chevron_right)

                ],
              ),),
            onTap: (){Router.pushNoParams(context, Router.bodyreport);},
          )
        ],
      ),
    );
  }
}
