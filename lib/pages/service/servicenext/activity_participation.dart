import 'package:flutter/material.dart';
import 'package:flutter_first/bean/region.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/service/servicenext/activity_list2.dart';
import 'package:flutter_first/util/dialog.dart';
import 'package:flutter_first/widgets/loading_widget.dart';

class ActivityParticipation extends StatefulWidget {
  @override
  _ActivityParticipationState createState() => _ActivityParticipationState();
}

class _ActivityParticipationState extends State<ActivityParticipation>
    with SingleTickerProviderStateMixin
    implements OnPressMunu {
  var tabText = [];
  TabController _tabController;
  List<Widget> tabs = [];
  List<Widget> tabViews = [];

  @override
  void initState() {
    _getActivityTab();
  }


  _getActivityTab() {
    DioUtils.instance.requestNetwork<RegionList>(
      Method.get,
      Api.GETREGIONLIST,
      onSuccess: (data) {
        print('活动TAB获取成功');
        setState(() {
          tabText = data.regionList;
          _tabController = TabController(length: tabText.length, vsync: this);
          tabText.forEach((item) {
            tabs.add(Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              child: Text(item),
            ));
          });
          tabText.forEach((item) {
            tabViews.add(ActivityList2(item));
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
  void onPress(int index) {
    _tabController.index = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff2CA687),
        title: Text(
          '活动参与',
        ),
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        child: _tabController == null
            ? LoadingWidget.childWidget()
            : Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Flex(
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    labelPadding: EdgeInsets.all(0.0),
                    indicatorColor: Color(0xff2CA687),
                    labelColor: Color(0xff2CA687),
                    indicator: const BoxDecoration(),
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
                child:
                    TabBarView(controller: _tabController, children: tabViews)),
          ],
        ),
      ),
    );
  }
}

abstract class OnPressMunu {
  void onPress(int index);
}
