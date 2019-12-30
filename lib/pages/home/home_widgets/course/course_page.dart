import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flukit/flukit.dart' as lib1;

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/banner.dart';
import 'package:flutter_first/bean/course.dart';
import 'package:flutter_first/bean/course_tag_entity.dart';
import 'package:flutter_first/bean/psycourse.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/psyCenter/service_child_widget.dart';
import 'package:flutter_first/pages/home/home_widgets/course/course_child.dart';
import 'package:flutter_first/pages/search_page.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/search.dart';
import 'package:flutter_first/widgets/top_panel.dart';

class PsyCourse extends StatefulWidget {
  @override
  _PsyCourseState createState() => _PsyCourseState();
}

class _PsyCourseState extends State<PsyCourse>
    with SingleTickerProviderStateMixin implements SlideTag{
  bool isShowLoading = false;
  List<Course> ecommendrList = List();
  List<Course> comingList = List(); //我的课程
  List<Course> lastTimeList = List(); //我的课程
  bool offstage = true;
  var tabText = [];
  List<Widget> tabs = [];
  List<Widget> tabViews = [];
  TabController mController;
  double mHeigh = 330.0;

  @override
  void initState() {
    _requestPsycourse();
    _getCourseTab();
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  _getCourseTab(){
    DioUtils.instance.requestNetwork<CourseTag>(
      Method.get,
      Api.GETTAGLIST,
      onSuccess: (data) {
        print('课程TAB获取成功');
        setState(() {
          tabText = data.tagList;
          mController = TabController(
            length: tabText.length,
            vsync: this,
          );
          tabText.forEach((item) {
            tabs.add(Text(item));
          });
          tabText.forEach((item) {
            tabViews.add(CourseChild(item,this));
          });
          isShowLoading = false;
        });
      },
      onError: (code, msg) {
        setState(() {
          print('课程tag获取失败！');
        });
      },
    );
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
                    controller: TextEditingController(),
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                    onTab: () {
                      NavigatorUtil.pushPage(context, SesrchPage('course','搜索课程'));
                    },
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
            child: tabText.isEmpty
                ? Container()
                :Column(
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
                ),
                Container(
                  height: mHeigh,
                  child: TabBarView(
                    controller: mController,
                    children: tabViews,
                  ),
                ),
                Container(
                  height: 20,
                  color: Color(0xFFEEEEEE),
                ),

              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
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
                      '【${comingList[index].name}】',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('类别：${comingList[index].category}',style: TextStyle(fontSize: 12),),
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
                      '【${comingList[index].name}】',
                      style: TextStyle(fontSize: 14),
                      maxLines: 1,overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('类别：${comingList[index].category}',style: TextStyle(color: Color(0xff909090),fontSize: 12),),
                    SizedBox(
                      height: 5,
                    ),
                    Text('课程时长：${comingList[index].courseCount??0}讲',style: TextStyle(color: Color(0xff909090),fontSize: 12),),
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

  @override
  void onSlide(double heigh) {
    setState(() {
      mHeigh = heigh;
      print('高度：$heigh');
    });
  }
}
abstract class SlideTag {
  void onSlide(double heigh);
}