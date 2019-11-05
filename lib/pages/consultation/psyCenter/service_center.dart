import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_center.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/psyCenter/service_child_widget.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCenterPage extends StatefulWidget {
  @override
  _ServiceCenterPageState createState() => _ServiceCenterPageState();
}

class _ServiceCenterPageState extends State<ServiceCenterPage> with SingleTickerProviderStateMixin {
  List<PsyServiceCenter> ServiceList = List();
  List<PsyServiceCenter> TypeList = List();
  bool isShowLoading = true; //\
  String type = "心理服务分中心";
  TabController mController;


  void initState() {
    super.initState();
    _requestPsyServiceCenterList();
    _requestPsyServiceCenterByType();

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

  void _requestPsyServiceCenterList() {
    DioUtils.instance.requestNetwork<PsyServiceCenter>(
        Method.get, Api.PsyServiceCenterList, isList: true,
        onSuccessList: (data) {
      setState(() {
        ServiceList = data;
        isShowLoading = false;
      });
    }, onError: (code, msg) {
      print("sssss");
    });
  }

  void _requestPsyServiceCenterByType() {
    DioUtils.instance.requestNetwork<PsyServiceCenter>(
        Method.get, Api.PsyServiceCenterByType,
        queryParameters: {"type": type}, isList: true, onSuccessList: (data) {
      setState(() {
        TypeList = data;
        isShowLoading = false;
      });
    }, onError: (code, msg) {
      print("sssss");
    });
  }

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);
    return Scaffold(
      backgroundColor: Colours.line,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          '服务中心',
          style: new TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black12,
        child: Column(
          children: <Widget>[

            SearchTextFieldWidget(
              margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
              color: Colors.white,
              isborder: true,
            ),
            Container(
              height: 80,
              child: TabBar(
                isScrollable: false,
                //是否可以滚动
                controller: mController,
                indicatorColor: Color(0xff2CA687),
                labelColor: Color(0xff2CA687),
                unselectedLabelColor: Color(0xff666666),
                labelStyle: TextStyle(fontSize: 16.0),
                tabs: <Widget>[
                  Text('按地区'),
                  Text('东城区'),
                  Text('西城区'),
                  Text('朝阳区'),
                  Text('海淀区'),
                  Text('丰台区'),

                ],
              ),
            ),
            Container(
              height: 80,
              child: TabBarView(
                controller: mController,
                children: <Widget>[
                  Text('你啊'),
                  Text('你啊'),
                  Text('你啊'),
                  Text('你啊'),
                  Text('你啊'),
                  Text('你啊'),
//                  ServiceChild(),
//                  ServiceChild(),
//                  ServiceChild(),
//                  ServiceChild(),
//                  ServiceChild(),
//                  ServiceChild(),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
