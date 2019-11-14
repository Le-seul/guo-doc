import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:flutter_first/bean/order_count.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/db/order_db.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/dialog.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/real_rich_text.dart';
import 'package:flutter_first/widgets/top_panel.dart';

class DoctorChunyuHomePage extends StatefulWidget {
  @override
  _DoctorChunyuHomePageState createState() => _DoctorChunyuHomePageState();
}

class _DoctorChunyuHomePageState extends State<DoctorChunyuHomePage> {
  StreamSubscription exitLogin;
  int orderCount = 0;
  String tuWenNum = '';
  String fastPhone = '';
  var db = OrderDb();

  @override
  void initState() {
    init();
    exitLogin = eventBus.on<refreshNum>().listen((event) {
      setState(() {
//        print('数据库evenBus');
        init();
      });
    });
  }

  @override
  void deactivate() {
    init();
  }

  init() async {
    List<Map> list = await db.getAllOrder();
//    print("数据库list3:$list");
    List<OrderNum> listNum = List();
    for (Map map in list) {
      listNum.add(OrderNum.fromJson(map));
    }
    int intTuWen = 0;
    int intFastPhone = 0;
    for (OrderNum orderNum in listNum) {
      setState(() {
        if (orderNum.location == "chunyuTuwen") {
          intTuWen = int.parse(orderNum.num) + intTuWen;
          tuWenNum = "$intTuWen";
//          print("tuWenNum2:$tuWenNum");
        } else {
          intFastPhone += int.parse(orderNum.num);
          fastPhone = "$intFastPhone";
        }
      });
    }

//    print("fastPhone:$intFastPhone");
  }

  @override
  void dispose() {
    super.dispose();
    exitLogin.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LoginTopPanel(),
          Column(
            children: <Widget>[
              SizedBox(
                height: 35,
              ),
              Center(
                child: Text(
                  '在线问诊',
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    child: MyCard(
                        child: Container(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '服务说明',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RealRichText(
                            [
                              TextSpan(
                                text: "欢迎您使用在线医生进行医疗咨询，该栏目是由",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    height: 1.5),
                              ),
                              TextSpan(
                                text: "北京市春雨医生软件有限公司",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    height: 1.5),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Router.push(
                                        context,
                                        'https://www.chunyuyisheng.com/',
                                        {'title': '在线问诊'});
                                  },
                              ),
                              TextSpan(
                                text: "提供支持。咨询医生均为全国三甲医院医生组成。",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    height: 1.5),
                              ),
                            ],
                            textScaleFactor: 1.1,
                          ),
                          RealRichText(
                            [
                              TextSpan(
                                text: "《图文问诊》 ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5),
                              ),
                              TextSpan(
                                text: "服务时间为7*24小时，医生将在6分钟内为您解答（夜间30分钟内）；",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    height: 1.5),
                              ),
                            ],
                            textScaleFactor: 1.1,
                          ),
                          RealRichText(
                            [
                              TextSpan(
                                text: "《快捷问诊》",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5),
                              ),
                              TextSpan(
                                text: "服务时间为每日早9：00——晚7：00，医生将在10分钟内向您回电。",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    height: 1.5),
                              ),
                            ],
                            textScaleFactor: 1.1,
                          ),
                          RealRichText(
                            [
                              TextSpan(
                                text: "如遇急重症病情，不适合网上咨询，请立即前往医院就诊。",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5),
                              ),
                            ],
                            textScaleFactor: 1.1,
                          ),
                        ],
                      ),
                    )),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: _gridItem(
                            'assets/images/doctor/graphic_consultation.png',
                            'doctor/graphic_icon.png',
                            '图文问诊',
                            "$tuWenNum",
                            tuWenNum == "0" || tuWenNum == ''),
                        onTap: () {
                          getOrderCount();
                          Router.pushNoParams(
                              context, Router.graphicConsultation);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: _gridItem(
                            'assets/images/doctor/quick_phone.png',
                            'doctor/phone_icon.png',
                            '电话问诊',
                            "$fastPhone",
                            fastPhone == "0" || fastPhone == ''),
                        onTap: () {
                          Router.pushNoParams(context, Router.telConsultation);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: _gridItem(
                            'assets/images/doctor/historical_record.png',
                            'doctor/history_icon.png',
                            '历史记录',
                            '',
                            true),
                        onTap: () {
                          Router.pushNoParams(context, Router.historyRecord);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text( '我们将竭尽全力保护您的隐私，',),
                  Text('严格遵守隐私及服务条款。'),
                  GestureDetector(
                      onTap: () {
                        Router.push(
                            context,
                            'http://49.232.168.124/phms_resource_base/HomePageDetail/PrivacyPolicy.htm',
                            {'title': '服务条款及隐私政策'});
                      },
                      child: Text(
                        '服务条款及隐私政策',
                        style: TextStyle(color: Colors.blue),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  getOrderCount() {
    DioUtils.instance.requestNetwork<OrderCount>(Method.get, Api.ORDERCOUNT,
        onSuccess: (data) {
      setState(() {
        orderCount = data.count;
        if (orderCount != 0) {
          showDialog<Null>(
              context: context, //BuildContext对象
              barrierDismissible: false,
              builder: (BuildContext context) {
                return ConsutationDialog();
              });
        }

//        showMySimpleDialog(context);
//        Toast.show('获取数量成功!');
      });
    }, onError: (code, msg) {
      setState(() {
//        Toast.show('获取数量失败!');
      });
    });
  }

  void showMySimpleDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new SimpleDialog(
            title: new Text("咨询问题"),
            children: <Widget>[
              new SimpleDialogOption(
                child: new Text("正在咨询$orderCount"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Router.pushNoParams(context, Router.historyRecord);
                },
              ),
              new SimpleDialogOption(
                child: new Text("新建咨询"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _gridItem(String bgImage, String icon, String text, String count, offstage) {
    return Container(
        child: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
                image: DecorationImage(
                    image: AssetImage(bgImage), fit: BoxFit.fill),
              ),
              child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        loadAssetImage(icon,
                            color: Colors.white,
                            height: 40,
                            width: 40,
                            fit: BoxFit.fill),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ))),
        ),
        Offstage(
          offstage: offstage,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Text(
                count,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
