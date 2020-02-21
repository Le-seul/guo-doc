import 'package:flutter/material.dart';
import 'package:flutter_first/bean/work_dunamics_tag.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/consultation_child_page.dart';
import 'package:flutter_first/res/colors.dart';
import 'dart:math' as math;
import 'package:flutter_first/widgets/loading_widget.dart';
import 'dynamics_details_page.dart';





  class WorkDynamics extends StatefulWidget {
    @override
    _WorkDynamicsState createState() => _WorkDynamicsState();
  }

  class _WorkDynamicsState extends State<WorkDynamics> with SingleTickerProviderStateMixin{
    bool isShowLoading = true;
    var tabText = [];
    TabController _tabController;
    List<Widget> tabs = [];
    List<Widget> tabViews = [];

    @override
    void initState() {
      super.initState();
      // 创建Controller
      _getTag();
    }

    _getTag() {
      DioUtils.instance.requestNetwork<WorkTag>(
        Method.get,
        Api.WORKTAG,
        onSuccess: (data) {
          print('工作动态TAB获取成功');
          setState(() {
            tabText = data.tagList;
            _tabController = TabController(length: tabText.length, vsync: this);
            tabText.forEach((item) {
              tabs.add(Text(item));
            });
            tabText.forEach((item) {
              tabViews.add(WorkDetail(true,item,false));
            });
            isShowLoading = false;
          });
        },
        onError: (code, msg) {
          setState(() {
            print('工作动态TAB获取失败！');
          });
        },
      );
    }
    @override
    Widget build(BuildContext context) {

      return SafeArea(
        child: Scaffold(
          body: isShowLoading
              ? LoadingWidget.childWidget()
              :Column(
            children: <Widget>[
              Container(
                  height: 30,
                  child:Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      TabBar(
                          isScrollable: true,
                          //是否可以滚动
                          controller: _tabController,
                          labelPadding:EdgeInsets.only(left: 5),
                          indicator: BoxDecoration(),
                          labelColor: Color(0xff2CA687),
                          unselectedLabelColor: Color(0xff666666),
                          unselectedLabelStyle: TextStyle(fontSize: 13),
                          labelStyle: TextStyle(fontSize: 13.0),
                          tabs: tabs
                      ),
                    ],)

              ),
              Flexible(
                child: TabBarView(
                    controller: _tabController,
                    children: tabViews
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

