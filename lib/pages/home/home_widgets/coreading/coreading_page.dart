import 'package:flutter/material.dart';
import 'package:flutter_first/bean/coreading.dart';
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
  TabController mController;
List<CoReading> Coreadinglist = List();
bool isShowLoading = true;
  void initState(){
    _requestImage();
    mController = TabController(
      length: 5,
      vsync: this,
    );
  }

  void _requestImage() {
    DioUtils.instance.requestNetwork<CoReading>(
        Method.get,
        Api.CoReading,
        isList: true,
        onSuccessList: (data) {
          setState(() {
            Coreadinglist = data;
            isShowLoading = false;

            //Coreadinglist.sort();

          });
        },
        onError: (code, msg) {
          print("sssss");
        });
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
            child: Column(
              children: <Widget>[
                SearchTextFieldWidget(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  color: Colors.white,
                  controller: TextEditingController(),
                  hintText: '搜索文章',
                  isborder: true,
                  onTab: (){
                    NavigatorUtil.pushPage(context, SesrchPage('article','搜索文章'));
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
                      isScrollable: false,
                      //是否可以滚动
                      controller: mController,
                      labelPadding:EdgeInsets.only(left: 5),
                      indicator: BoxDecoration(),
                      labelColor: Color(0xff2CA687),
                      unselectedLabelColor: Color(0xff666666),
                      unselectedLabelStyle: TextStyle(fontSize: 13),
                      labelStyle: TextStyle(fontSize: 13.0),
                      tabs: <Widget>[
                        Text('全部文章'),
                        Text('情绪压力'),
                        Text('咨询科普'),
                        Text('亲密关系'),
                        Text('个人成长'),
                      ],
                    ),)
                  ],)



                ),
                Flexible(
                  child: TabBarView(
                    controller: mController,
                    children: <Widget>[
                      CoreadingChild(Kind:''),
                      CoreadingChild(Kind:'情绪压力'),
                      CoreadingChild(Kind:'咨询科普'),
                      CoreadingChild(Kind:'亲子关系'),
                      CoreadingChild(Kind:'个人成长'),
                    ],
                  ),
                ),
              ],
            ),
          )
    );
  }
}
