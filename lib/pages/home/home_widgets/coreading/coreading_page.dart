import 'package:flutter/material.dart';
import 'package:flutter_first/bean/coreading.dart';
import 'package:flutter_first/bean/coreadinglist.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/psyCenter/service_child_widget.dart';
import 'package:flutter_first/pages/search_page.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'coreading_child_page.dart';

class SimpleCoreading extends StatefulWidget {
  @override
  _SimpleCoreadingState createState() => _SimpleCoreadingState();
}

class _SimpleCoreadingState extends State<SimpleCoreading>
    with SingleTickerProviderStateMixin {

  bool isShowLoading = true;
  var tabText = [];
  TabController _tabController;
  List<Widget> tabs = [];
  List<Widget> tabViews = [];

  void initState(){
    _getCoreadingTab();
  }

  _getCoreadingTab() {
    DioUtils.instance.requestNetwork<Coreadinglist>(
      Method.get,
      Api.CoReadingTag,
      onSuccess: (data) {
        print('共读获取成功');
        setState(() {
          tabText = data.tagList;
          _tabController = TabController(length: tabText.length+1, vsync: this);
          tabs.add(Text('全部文章'));
          tabText.forEach((item) {
            tabs.add(Text(item));
          });
          tabViews.add(CoreadingChild(Kind:'全部文章'));
          tabText.forEach((item) {
            tabViews.add(CoreadingChild(Kind:item));
          });
          print('活动TAB获取成功');
        });
      },
      onError: (code, msg) {
        setState(() {

          print('活动TAB获取失败！');
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);
    return Scaffold(
      backgroundColor: Colours.line,
      appBar: AppBar(
        title: Text('心理共读'),
          centerTitle: true,
        backgroundColor: Colours.bg_green,
      ),
      body:Container(
            color: Color(0xFFEEEEEE),
            child: _tabController == null
                ? LoadingWidget.childWidget()
                :Column(
              children: <Widget>[
                SearchTextFieldWidget(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  color: Colors.white,
                  controller: TextEditingController(),
                  hintText: '搜索文章',
                  isborder: true,
                  onTab: (){
                    NavigatorUtil.pushPage(context, SesrchPage('psyCoReading','搜索文章'));
                  },
                ),
                Container(
                  height: 30,
                  child:Flex(
                    direction: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Text('类别:',style: TextStyle(fontSize: 13,color:Color(0xff666666) ),),
                      ),
                      margin: EdgeInsets.only(left: 15),
                      padding: EdgeInsets.only(bottom: 2),
                    ),
                    Expanded(child: TabBar(
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
                    ),)
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
          )
    );
  }
}
