import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/consultation_page.dart';

import 'package:flutter_first/pages/home/home_page.dart';
import 'package:flutter_first/pages/mine/mine_page.dart';
import 'package:flutter_first/pages/selfhelp/selfhelp_page.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

import 'service/service_page.dart';

///这个页面是作为整个APP的最外层的容器，以Tab为基础控制每个item的显示与隐藏
class ContainerPage extends StatefulWidget {
  ContainerPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContainerPageState();
  }
}

class _Item {
  String name, activeIcon, normalIcon;
  _Item(this.name, this.activeIcon, this.normalIcon);
}

class _ContainerPageState extends State<ContainerPage> {
  List<Widget> pages;

  final defaultItemColor = Color.fromARGB(255, 125, 125, 125);

  final itemNames = [
    _Item('首页', 'navigation/ic_tab_home_active.png', 'navigation/ic_tab_home_normal.png'),
    _Item('资讯', 'navigation/ic_tab_information_active.png', 'navigation/ic_tab_information_normal.png'),
    _Item('服务', 'navigation/ic_tab_service_active.png', 'navigation/ic_tab_service_normal.png'),
    _Item('自助', 'navigation/ic_tab_selfhelp_active.png', 'navigation/ic_tab_selfhelp_normal.png'),
    _Item('我的', 'navigation/ic_tab_mine_active.png', 'navigation/ic_tab_mine_normal.png')
  ];

  List<BottomNavigationBarItem> itemList;

  @override
  void initState() {
    super.initState();
    print('initState _ContainerPageState');
    if (Platform.isAndroid) {
      JPush jpush = StorageManager.jpush;
      SchedulerBinding.instance.addPostFrameCallback((_) => {
            jpush.getRegistrationID().then((rid) {
              setState(() {
                print("获取注册的id:$rid");
                saveRegistrationID(rid);
              });
            }),
            jpush.setup(appKey: "565a2f927e82c11287326979", channel: 'developer-default'),
            // 监听jpush
            jpush.addEventHandler(
              onReceiveNotification: (Map<String, dynamic> message) async {
//                print("flutter 接收到推送消息1: ${json.encode(message)}");
                print("flutter 接收到推送消息1: $message");
                print("flutter 接收到推送消息2: ${message["extras"]}");
                print("flutter 接收到推送消息3: ${message["extras"]["cn.jpush.android.EXTRA"]}");
//                print("flutter 接收到推送消息5: ${message["extras"]["cn.jpush.android.EXTRA"]["orderId"]}");
                print("flutter 接收到推送消息4: ${json.decode(message["extras"]["cn.jpush.android.EXTRA"])["orderId"]}");

              },
              onOpenNotification: (Map<String, dynamic> message) {
                // 点击通知栏消息，在此时通常可以做一些页面跳转等
                String orderId = json.decode(message["extras"]["cn.jpush.android.EXTRA"])["orderId"];
                print("orderid：$orderId");
                Toast.show('点击通知');
                Router.push(
                    context,Router.talk,
                    orderId
                );
              },
            ),
          });


    }

    if (pages == null) {
      pages = [HomePage(), ConsultationPage(), ServicePage(), SelfHelpPage(), MinePage()];
    }
    if (itemList == null) {
      itemList = itemNames
          .map((item) => BottomNavigationBarItem(
              icon: loadAssetImage(
                item.normalIcon,
                width: 22.0,
                height: 22.0,
              ),
              title: Text(
                item.name,
                style: TextStyle(fontSize: 10.0),
              ),
              activeIcon: loadAssetImage(item.activeIcon, width: 22.0, height: 22.0)))
          .toList();
    }
  }

  int _selectIndex = 0;

  static saveRegistrationID(String registrationID) async {
    StorageManager.sharedPreferences.setString(Constant.registrationID, registrationID);
  }

//Stack（层叠布局）+Offstage组合,解决状态被重置的问题
  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }

  @override
  void didUpdateWidget(ContainerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    print('build _ContainerPageState');
    return Scaffold(
      body: new Stack(
        children: [
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
          _getPagesWidget(3),
          _getPagesWidget(4),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (int index) {
          ///这里根据点击的index来显示，非index的page均隐藏
          setState(() {
            _selectIndex = index;
            //这个是用来控制比较特别的shopPage中WebView不能动态隐藏的问题
          });
        },
        //图标大小
        iconSize: 24,
        //当前选中的索引
        currentIndex: _selectIndex,
        //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
        fixedColor: Color.fromARGB(255, 0, 188, 96),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
