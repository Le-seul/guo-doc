//import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/home/doctor/search_hospital_detail.dart';
import 'package:flutter_first/pages/search_page.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/search.dart';

class SearchHospital extends StatefulWidget {
  @override
  _SearchHospitalState createState() => _SearchHospitalState();
}

class _SearchHospitalState extends State<SearchHospital>
    with SingleTickerProviderStateMixin {
  TabController mController;

  @override
  void initState() {
    super.initState();

    mController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '找医院',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.8,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Container(
              height: 24,
              width: 24,
              margin: EdgeInsets.only(right: 15),
              child: loadAssetImage('share.png'
                 ),
            ),
            onTap: (){
//              Share.text(
//                  '我的分享',
//                  '北京协和医院:\nhttps://baike.baidu.com/item/%E5%8C%97%E4%BA%AC%E5%8D%8F%E5%92%8C%E5%8C%BB%E9%99%A2/322752?fr=aladdin',
//                  'text/plain');
            },
          )
        ],
      ),
      body: Container(
        color: Color(0xffF9F9F9),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            SearchTextFieldWidget(
              isborder: true,
              controller: TextEditingController(),
              hintText: '请输入搜索内容',
              margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              onTab: () {
                NavigatorUtil.pushPage(context, SesrchPage('hospital','请输入搜索内容'));
              },
            ),
            Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: MyCard(
                      child: Column(
                    children: <Widget>[
                      Container(
                        height: 38,
                        child: TabBar(
                          isScrollable: false,
                          //是否可以滚动
                          controller: mController,
                          indicatorColor: Colors.white,
                          labelColor: Color(0xff2CA687),
                          unselectedLabelColor: Color(0xff666666),
                          labelStyle: TextStyle(fontSize: 16.0),
                          tabs: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('全国'),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('综合'),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: mController,
                          children: <Widget>[
                            _getList(),
                            _getList(),
                          ],
                        ),
                      )
                    ],
                  )),
                ))
          ],
        ),
      ),
    );
  }

  _getList() {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => _buildItem(index),
    );
  }

  _buildItem(int index) {
    Widget itemWidget;
    String num;

    if (index < 9) {
      num = "0" + "${index + 1}";
    } else {
      num = "${index + 1}";
    }
    if (index == 0) {
      itemWidget = Container(
        child: loadAssetImage('doctor/first.png', fit: BoxFit.fill),
        padding: EdgeInsets.only(left: 4, right: 4),
      );
    } else if (index == 1) {
      itemWidget = Container(
        child: loadAssetImage('doctor/second.png', fit: BoxFit.fill),
        padding: EdgeInsets.only(left: 4, right: 4),
      );
    } else if (index == 2) {
      itemWidget = Container(
        child: loadAssetImage('doctor/third.png', fit: BoxFit.fill),
        padding: EdgeInsets.only(left: 4, right: 4),
      );
    } else {
      itemWidget = Container(
        padding: EdgeInsets.all(4),
        child: CircleAvatar(
          backgroundColor: Colors.black12,
          radius: 10,
          child: Text(
            num,
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pushPage(context,SearchHospitalDetail());
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: <Widget>[
            Container(
              height: 1,
              color: Colors.black26,
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: itemWidget,
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '北京协和医院',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '全国综合排名第一',
                          style: TextStyle(color: Colors.black26),
                        ),
                      ],
                    ),
                  ),
                  Text('北京东城区', style: TextStyle(color: Colors.black26)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
