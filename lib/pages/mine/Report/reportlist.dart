import 'package:flutter/material.dart';
import 'package:flutter_first/bean/HealthYear.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/mine/Report/bodyreport.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/navigator_util.dart';



class ReportList extends StatefulWidget {
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {

  List<HearthYear> healthYearList = new List();
  @override
  void initState() {
    _getHealthReport();
  }

  _getHealthReport(){
    DioUtils.instance.requestNetwork<HearthYear>(
      Method.get,
      Api.GETYEARLIST,
      isList: true,
      onSuccessList: (data) {
        setState(() {
          healthYearList = data;
        });
      },
      onError: (code, msg) {
        setState(() {
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('体检报告'),
        centerTitle: true,
        backgroundColor: Colours.bg_green,
      ),
      body: Container(
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: healthYearList.length,
            itemBuilder: (context, index) => _buildItem(index),
          ))
    );
  }
  _buildItem(int index){
    return GestureDetector(
      onTap: (){
        NavigatorUtil.pushWebView(context,'http://49.232.168.124/phms_resource_base/psyReading/XinLiXueWZ_CZ.html',{"title": '体检报告','year':healthYearList[index].year,'redirection':true});
      },
      child: Container(
        padding: EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(width: 20,),
            Image.asset('assets/images/tijian.png'),
            Expanded(child: Center(child: Text('${healthYearList[index].year}体检报告',style: TextStyle(fontSize: 17),))),
            Icon(Icons.chevron_right),
            SizedBox(width: 20,),

      ],
        ),),);
  }

}
