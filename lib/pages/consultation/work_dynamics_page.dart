import 'package:flutter/material.dart';
import 'package:flutter_first/res/colors.dart';
import 'dart:math' as math;

TabController _tabController;
List tabs = ["sssss", "sssss", "sssss"];

List<Widget> tabList=[
  Text('sssss',style: TextStyle(fontSize: 15,),),
  Text('dddddd',style: TextStyle(fontSize: 15,),),
  Text('safsa',style: TextStyle(fontSize: 15,),),

];

class WorkDynamics extends StatefulWidget {
  @override
  _WorkDynamicsState createState() => _WorkDynamicsState();
}

class _WorkDynamicsState extends State<WorkDynamics> with SingleTickerProviderStateMixin{
  TabController _tabController; //需要定义一个Controller
  List tabs = ["ddddd", "dddd", "ddddd"];
  List<Widget> tabview = [
    ssssss(),
    Text('ssss'),
    Text('ssss'),

  ];
  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        bottom: TabBar(   //生成Tab菜单
        controller: _tabController,
        tabs: tabs.map((e) => Tab(text: e)).toList()
    ),),

      body: TabBarView(
        controller: _tabController,
        children: tabview,
      ),
    );
    }
}



  class ssssss extends StatefulWidget {
    @override
    _ssssssState createState() => _ssssssState();
  }

  class _ssssssState extends State<ssssss> with SingleTickerProviderStateMixin{

    @override
    void initState() {
      super.initState();
      // 创建Controller
      _tabController = TabController(length: tabs.length, vsync: this);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: DefaultTabController(
              length: tabs.length,
              child: _getNestedScrollView(HomePageTabBar())),
        ),
      );
    }
    Widget _getNestedScrollView(Widget tabBar) {
      return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                      maxHeight: 40.0,
                      minHeight: 35.0,
                      child: Container(
                        height: 37.0,
                        color: Colors.white,
                        child: tabBar,
                      ))),
            ];
          },
          body: TabBarView(
           controller: _tabController,
            children:tabList,
          ));
    }
  }


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max((minHeight ?? kToolbarHeight), minExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class HomePageTabBar extends StatefulWidget {
  HomePageTabBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageTabBarState();
  }
}

class _HomePageTabBarState extends State<HomePageTabBar> {
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;

  @override
  void initState() {
    super.initState();
    selectColor = Color(0xff2CA687);
    unselectedColor = Colors.black;
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 18, color: selectColor);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Tab小部件列表
//    List<Widget>  @required this.tabs,
    //组件选中以及动画的状态
//   TabController this.controller,
    //Tab是否可滑动(false->整个tab会把宽度填满，true-> tab包裹)
//  bool  this.isScrollable = false,
    //选项卡下方的导航条的颜色
//   Color this.indicatorColor,
    //选项卡下方的导航条的线条粗细
//   double this.indicatorWeight = 2.0,
//  EdgeInsetsGeometry  this.indicatorPadding = EdgeInsets.zero,
//   Decoration this.indicator,
//   TabBarIndicatorSize this.indicatorSize,导航条的长度，（tab：默认等分；label：跟标签长度一致）
//  Color  this.labelColor,所选标签标签的颜色
//  TextStyle  this.labelStyle,所选标签标签的文本样式
//  EdgeInsetsGeometry  this.labelPadding,,所选标签标签的内边距
// Color   this.unselectedLabelColor,未选定标签标签的颜色
//  TextStyle  this.unselectedLabelStyle,未选中标签标签的文字样式
//   void Function(T value) this.onTap,按下时的响应事件
    return Container(
//      margin: EdgeInsets.only(top:0),
      color: Colours.line,
      child: TabBar(
        tabs: tabs.map((e) => Tab(text: e)).toList(),
        isScrollable: true,
        controller: _tabController,
        indicatorColor: selectColor,
        labelColor: selectColor,
        labelStyle: selectStyle,
        unselectedLabelColor: unselectedColor,
        unselectedLabelStyle: unselectedStyle,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}