import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_center.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/psyCenter/service_child2.dart';
import 'package:flutter_first/pages/consultation/psyCenter/service_child_widget.dart';
import 'package:flutter_first/pages/service/servicenext/activity_participation.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/dialog.dart';

import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCenterPage extends StatefulWidget {
  @override
  _ServiceCenterPageState createState() => _ServiceCenterPageState();
}

class _ServiceCenterPageState extends State<ServiceCenterPage>
    with SingleTickerProviderStateMixin {
  List<PsyServiceCenter> ServiceList = List();
  List<PsyServiceCenter> TypeList = List();
  bool isShowLoading = true; //\
  String type = "心理服务分中心";
  TabController mController;

  void initState() {
    super.initState();
    mController = TabController(
      length: 7,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);
    return Scaffold(
        backgroundColor: Colours.line,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            '心理服务中心',
            style: new TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Container(
          color: Color(0xFFEEEEEE),
          child: Column(
            children: <Widget>[
              SearchTextFieldWidget(
                margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                color: Colors.white,
                hintText: '请输入',
                isborder: true,
              ),
              Container(
                height: 30,
                child: TabBar(
                  isScrollable: true,
                  //是否可以滚动
                  controller: mController,
                  labelPadding:EdgeInsets.all(0.0),
                  indicatorColor: Color(0xff2CA687),
                  labelColor: Color(0xff2CA687),
                  unselectedLabelColor: Color(0xff666666),
                  unselectedLabelStyle: TextStyle(fontSize: 14),
                  labelStyle: TextStyle(fontSize: 16.0),
                  tabs: <Widget>[
                    Container(

                        child: Text('全部'),
                      margin: EdgeInsets.fromLTRB(5, 0, 9, 0),
                    ),
                    Container(

                      child: Text('直属单位'),
                      margin: EdgeInsets.fromLTRB(5, 0, 9, 0),
                    ),
                    Container(

                      child: Text('东城'),
                      margin: EdgeInsets.fromLTRB(5, 0, 9, 0),
                    ),
                    Container(

                      child: Text('西城'),
                      margin: EdgeInsets.fromLTRB(5, 0, 9, 0),
                    ),Container(

                      child: Text('朝阳'),
                      margin: EdgeInsets.fromLTRB(5, 0, 9, 0),
                    ),Container(

                      child: Text('海淀'),
                      margin: EdgeInsets.fromLTRB(5, 0, 9, 0),
                    ),

                    Container(
                      child: Text('丰台'),
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    ),


                  ],
                ),
              ),
              Flexible(
                child: TabBarView(
                  controller: mController,
                  children: <Widget>[
                  ServiceChild(''),
                  ServiceChild2('直属单位'),
                  ServiceChild('东城区'),
                  ServiceChild('西城区'),
                  ServiceChild('朝阳区'),
                  ServiceChild('海淀区'),
                  ServiceChild('丰台区'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
