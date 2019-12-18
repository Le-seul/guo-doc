import 'package:flutter/material.dart';
import 'package:flutter_first/bean/test_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/dialog.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';

import 'everydaytestpage.dart';

class DayTest extends StatefulWidget {
  @override
  _DayTestState createState() => _DayTestState();
}

class _DayTestState extends State<DayTest>  with SingleTickerProviderStateMixin {
  List<Widget> tabs = [];
  List<Widget> tabViews = [];
  var tabText = [];
  TabController _tabController;

  @override
  void initState(){
    _getTestTag();

  }
  _getTestTag() {
    DioUtils.instance.requestNetwork<TestTag>(Method.get, Api.PsyDailyTAG,
          onSuccess: (data) {
            print('自测TAB获取成功');
            setState(() {
              tabText = data.regionList;
              _tabController = TabController(length: tabText.length, vsync: this);
              tabText.forEach((item) {
                tabs.add(Text(item));
              });
              tabText.forEach((item) {
                tabViews.add(EverydayTest(item));
              });
              print('自测TAB获取成功');
            });

        }, onError: (code, msg) {
          Toast.show('请求失败！');
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff2CA687),
        title: Text(
          '趣味自测',
        ),
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        child: _tabController == null
            ? LoadingWidget.childWidget()
            : Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Flex(
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    labelPadding:EdgeInsets.only(left: 8,right: 8,bottom: 5,top: 5),
                    indicatorColor: Color(0xff2CA687),
                    labelColor: Color(0xff2CA687),
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Color(0xff666666),
                    unselectedLabelStyle: TextStyle(fontSize: 14),
                    labelStyle: TextStyle(fontSize: 14.0),
                    tabs: tabs,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Flexible(
                child:
                TabBarView(controller: _tabController, children: tabViews)),
          ],
        ),
      ),
    );
  }
}
