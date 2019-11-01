import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/all_order_entity.dart';
import 'package:flutter_first/bean/message.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:flutter_first/db/order_db.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/my_card.dart';

class CurrentConsultation extends StatefulWidget {
  @override
  _CurrentConsultationState createState() => _CurrentConsultationState();
}

class _CurrentConsultationState extends State<CurrentConsultation> {
  bool isShowLoading = true;
  StreamSubscription exitLogin;
  AllOrder allOrder = new AllOrder();
  var db = OrderDb();


  @override
  void initState() {

    _getOrderInProgress();
    exitLogin = eventBus.on<refreshNum>().listen((event) {
      setState(() {
        if(event.location == 'chunyuTuwen'){
          for (TuwenOrder tuwenOrder in allOrder.tuwenOrder) {
            if(event.orderId == tuwenOrder.id){
              tuwenOrder.num = event.num;
            }
            print("tuWenNum3:${tuwenOrder.num}");
          }
        }
        if(event.location == 'fastFhone'){
          for (FastphoneOrder fastphoneOrder in allOrder.fastphoneOrder) {
            if(event.orderId == fastphoneOrder.id){
              fastphoneOrder.num = event.num;
            }
            print("fastPhone:${fastphoneOrder.num}");
          }
        }
      });
    });
  }


  @override
  void dispose() {
    exitLogin.cancel();
    db.close();
  }

  @override
  void deactivate() {
    _getOrderInProgress();
  }
  getNum(AllOrder allOrder) async {
    print("tuWenNum4:开始查询");

    for (TuwenOrder tuwenOrder in allOrder.tuwenOrder) {
      print("tuWenNum4:${tuwenOrder.id}");
      OrderNum orderNum = await db.getOrder(tuwenOrder.id);
      print("数据库5:${orderNum.orderId}");
      setState(() {
        if(orderNum != null){
          tuwenOrder.num = orderNum.num??"";
        }

      });

      print("tuWenNum4:${tuwenOrder.num}");
    }
    for (FastphoneOrder fastphoneOrder in allOrder.fastphoneOrder) {
      OrderNum orderNum = await db.getOrder(fastphoneOrder.id);
      setState(() {
        if(orderNum != null){
          fastphoneOrder.num = orderNum.num??"";
        }

      });

      print("fastPhone:${fastphoneOrder.num}");
    }
  }

  _getOrderInProgress() {
    DioUtils.instance.requestNetwork<AllOrder>(
        Method.get, Api.GETORDERINPROGRESS, onSuccess: (data) {
      setState(() {
        allOrder = data;
        isShowLoading = false;
        getNum(allOrder);
        print("data:${data.toString()}");
        print('获取进行订单成功！');
      });
    }, onError: (code, msg) {
      setState(() {
        print('获取进行订单失败!');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isShowLoading
        ? LoadingWidget.childWidget()
        : allOrder.tuwenOrder.length == 0 && allOrder.fastphoneOrder.length == 0
            ? Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Text('暂无数据'),
              )
            : ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allOrder.tuwenOrder.length,
                      itemBuilder: (context, index) {
                        return _buildItem(index, allOrder.tuwenOrder[index].num,
                            allOrder.tuwenOrder[index].num == "");
                      }),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allOrder.fastphoneOrder.length,
                      itemBuilder: (context, index) {
                        return _buildItem1(
                            index,
                            allOrder.fastphoneOrder[index].num,
                            allOrder.fastphoneOrder[index].num == "");
                      }),
                ],
              );
  }

  _buildItem(int index, String num, bool offstage) {
    return GestureDetector(
        onTap: () {
          Router.push(context, Router.talk,
              {'orderId': allOrder.tuwenOrder[index].id, 'offstage': false,'type':"tuwen"});
        },
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: MyCard(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage:
                        allOrder.tuwenOrder[index].doctorImage == null?AssetImage('assets/images/beijing2.jpg'):NetworkImage(allOrder.tuwenOrder[index].doctorImage),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            allOrder.tuwenOrder[index].doctorName ?? "",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            allOrder.tuwenOrder[index].createTime ?? "",
                            style: TextStyle(color: Colors.black26),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Offstage(
              offstage: offstage,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                  padding:
                      EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    num??"",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  _buildItem1(int index, String num, bool offstage) {
    return GestureDetector(
        onTap: () {
          Router.push(context, Router.talk,
              {'orderId': allOrder.fastphoneOrder[index].id, 'offstage': true,'type':"fastphone"});
        },
        child: Stack(children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: MyCard(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: allOrder.fastphoneOrder[index].doctorImage == null?AssetImage('assets/images/beijing2.jpg'):NetworkImage(allOrder.tuwenOrder[index].doctorImage),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          allOrder.fastphoneOrder[index].doctorName ?? "",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          allOrder.fastphoneOrder[index].createTime ?? "",
                          style: TextStyle(color: Colors.black26),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Offstage(
            offstage: offstage,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 10, right: 10),
                padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Text(
                  num??"",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ]));
  }
}
