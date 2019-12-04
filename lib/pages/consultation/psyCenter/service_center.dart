import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_center.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
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
    with SingleTickerProviderStateMixin implements OnPressMunu{
  List<PsyServiceCenter> ServiceList = List();
  List<PsyServiceCenter> TypeList = List();
  bool isShowLoading = true; //\
  String type = "心理服务分中心";
  var tabText = ['按地区','东城区', '西城区', '朝阳区', '海淀区', '丰台区'];
  TabController mController;
  List<Widget> tabs = [];
  List<Widget> tabViews = [];

  void initState() {
    super.initState();
    mController = TabController(
      length: tabText.length,
      vsync: this,
    );
    tabText.forEach((item) {
      tabs.add(Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
        child: Text(item),
      ));
    });
    tabText.forEach((item) {
      tabViews.add(ServiceChild(item));
    });
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
              Flex(
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: TabBar(
                      isScrollable: true,
                      //是否可以滚动
                      controller: mController,
                      labelPadding:EdgeInsets.all(0.0),
                      indicatorColor: Color(0xff2CA687),
                      labelColor: Color(0xff2CA687),
                      unselectedLabelColor: Color(0xff666666),
                      unselectedLabelStyle: TextStyle(fontSize: 14),
                      labelStyle: TextStyle(fontSize: 14.0),
                      tabs: tabs,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false, //BuildContext对象
                            builder: (BuildContext context) {
                              return ShowActivityTab(tabText, this);
                            });
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Center(child: Icon(Icons.menu)))),
                ],
              ),
              Flexible(
                child: TabBarView(
                  controller: mController,
                  children: tabViews
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void onPress(int index) {
    mController.index = index;
  }
}
