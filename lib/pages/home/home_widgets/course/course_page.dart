import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flukit/flukit.dart' as lib1;

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/banner.dart';
import 'package:flutter_first/bean/course.dart';
import 'package:flutter_first/bean/psycourse.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/psyCenter/service_child_widget.dart';
import 'package:flutter_first/pages/home/home_widgets/course/course_child.dart';
import 'package:flutter_first/res/colors.dart';

import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/search.dart';
import 'package:flutter_first/widgets/top_panel.dart';

class PsyCourse extends StatefulWidget {
  @override
  _PsyCourseState createState() => _PsyCourseState();
}

class _PsyCourseState extends State<PsyCourse>
    with SingleTickerProviderStateMixin {
  bool isShowLoading = false;
  List<Course> ecommendrList = List();
  List<Course> comingList = List(); //我的课程
  List<Course> lastTimeList = List(); //我的课程
  bool offstage = true;
  TabController mController;

  @override
  void initState() {
    _requestPsycourse();
    mController = TabController(
      length: 6,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  void _requestPsycourse() {
    DioUtils.instance.requestNetwork<Course>(Method.get, Api.GETALLCOUTSE,
        isList: true, onSuccessList: (data) {
      setState(() {
        for (Course course in data) {
          if (course.state == 'YFB') {
            ecommendrList.add(course);
          } else if (course.state == 'JJFB') {
            comingList.add(course);
          } else {
            lastTimeList.add(course);
          }
        }
        ;
        if (lastTimeList.length != 0) {
          offstage = false;
        }
        print("获取课程成功！");
      });
    }, onError: (code, msg) {
      print("获取课程失败！");
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('心理课程'),
        centerTitle: true,
        backgroundColor: Colours.bg_green,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              color: Color(0xFFEEEEEE),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  SearchTextFieldWidget(
                    isborder: false,
                    hintText: '搜索课程',
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                    onTab: () {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Offstage(
                    offstage: offstage,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 2,
                                height: 16,
                                color: Color(0xff2CA687),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '上次收听',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) => _buildItem1(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 2,
                        height: 16,
                        color: Color(0xff2CA687),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '课程推荐',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('类别：')),
                      Expanded(
                        child: TabBar(
                          isScrollable: true,
                          //是否可以滚动
                          controller: mController,
                          labelPadding: EdgeInsets.only(left: 5, right: 5),
                          indicatorColor: Color(0xff2CA687),
                          labelColor: Color(0xff2CA687),
                          indicatorSize: TabBarIndicatorSize.label,
                          unselectedLabelColor: Color(0xff666666),
                          unselectedLabelStyle: TextStyle(fontSize: 14),
                          labelStyle: TextStyle(fontSize: 14.0),
                          tabs: <Widget>[
                            Container(child: Text('全部'),margin: EdgeInsets.only(left: 4,right: 4),),
                            Container(child: Text('情绪调节'),margin: EdgeInsets.only(left: 4,right: 4),),
                            Container(child: Text('亲密关系'),margin: EdgeInsets.only(left: 4,right: 4),),
                            Container(child: Text('自我成长'),margin: EdgeInsets.only(left: 4,right: 4),),
                            Container(child: Text('咨询培训'),margin: EdgeInsets.only(left: 4,right: 4),),
                            Container(child: Text('简单共读'),margin: EdgeInsets.only(left: 4,right: 4),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 330,
              child: TabBarView(
                controller: mController,
                children: <Widget>[
                  CourseChild(ecommendrList),
                  CourseChild(ecommendrList),
                  CourseChild(ecommendrList),
                  CourseChild(ecommendrList),
                  CourseChild(ecommendrList),
                  CourseChild(ecommendrList),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Container(
                  height: 20,
                  color: Color(0xFFEEEEEE),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 2,
                        height: 16,
                        color: Color(0xff2CA687),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '即将上线',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: comingList.length,
                    itemBuilder: (context, index) => _buildItem(index),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildItem1(int index) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          index == 0
              ? Container()
              : Container(
                  height: 1,
                  color: Colors.black12,
                ),
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://www.aireading.club/phms_resource_base/image_base/疗愈和父母的关系.jpg',
                    width: 150,
                    height: 90,
                    fit: BoxFit.fitHeight,
                  )),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '【怎么管理情绪】',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('类别：情绪调节',style: TextStyle(fontSize: 12),),
                    SizedBox(
                      height: 5,
                    ),
                    Flex(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 15,
                        ),
                        Expanded(child: Text('上次听到:01讲 05分22秒',style: TextStyle(fontSize: 12),))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Text('点击继续收听'),
                        Icon(
                          Icons.chevron_right,
                          size: 15,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  _buildItem(int index) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          index == 0
              ? Container()
              : Container(
                  height: 1,
                  color: Colors.black12,
                ),
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment:Alignment.center,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        comingList[index].coverImage,
                        width: 110,
                        height: 80,
                        fit: BoxFit.fitHeight,
                      )),
                  Container(
                    width: 110,
                    height: 80,
                    child: Text("1"),
                    decoration: BoxDecoration(color: Color(0x90000000),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  Text('敬请期待',style: TextStyle(color: Colors.white ,fontStyle: FontStyle.italic,),)
                ],
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '【怎么管理情绪】',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('类别：情绪调节',style: TextStyle(color: Color(0xff909090),fontSize: 12),),
                    SizedBox(
                      height: 5,
                    ),
                    Text('课程时长：16讲',style: TextStyle(color: Color(0xff909090),fontSize: 12),),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 15,color: Color(0xff909090)
                        ),
                        SizedBox(width:5,),
                        Text('预计${comingList[index].publishTime.substring(0,10)}上线',style: TextStyle(color: Color(0xFFFF5400),fontSize: 12))
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '即将上线',
                style: TextStyle(color: Color(0xFFFBB723)),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
