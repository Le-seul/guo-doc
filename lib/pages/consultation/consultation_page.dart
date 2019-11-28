import 'package:flutter/material.dart';
import 'package:flutter_first/bean/consultation_columns_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/consultation_tab.dart';
import 'package:flutter_first/res/colors.dart';
import 'dart:math' as math;

import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';

TabController _tabController;
List<Widget> tabList;

//资讯页面
class ConsultationPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ConsultationPageState();
  }
}

class _ConsultationPageState extends State<ConsultationPage>
    with SingleTickerProviderStateMixin {
  bool isShowLoading = true;
  List<ConsulationColumns> columnsList = List();

  @override
  void initState() {
    _getColumns();
  }

  _getColumns() {
    DioUtils.instance.requestNetwork<ConsulationColumns>(
      Method.get,
      Api.GETAllCOlUMN,
      isList: true,
      onSuccessList: (data) {
        setState(() {
          columnsList = data;
          tabList = getTabList();
          isShowLoading = false;
          _tabController = TabController(vsync: this, length: tabList.length);
        });
      },
      onError: (code, msg) {
        setState(() {
          isShowLoading = false;
          Toast.show('请求失败！');
        });
      },
    );
  }

  List<Widget> getTabList() {
    if (columnsList != null || columnsList.length > 0) {
      return columnsList
          .map((item) => Text(
                item.name,
                style: TextStyle(
                  fontSize: 15,
                ),
              ))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('资讯'),
        backgroundColor: Color(0xff2CA687),
        centerTitle: true,
      ),
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : columnsList.length == 0
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text('暂无数据'),
                )
              : SafeArea(
                  child: DefaultTabController(
                      length: columnsList.length,
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
        body: FlutterTabBarView(
          tabController: _tabController,
          columnsList: columnsList,
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
    selectColor = Colors.orangeAccent;
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
      color: Color(0xFFFFEBEE),
      child: TabBar(
        tabs: tabList,
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
