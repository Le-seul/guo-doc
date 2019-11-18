import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/history_order_entity.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:flutter_first/bean/progress_order_entity.dart';
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
  List<ProgressOrder> progressOrderList = List();
  var db = OrderDb();


  @override
  void initState() {

    _getOrderInProgress();
    exitLogin = eventBus.on<refreshNum>().listen((event) {
      setState(() {
        for (ProgressOrder progressOrder in progressOrderList) {
          if(event.orderId == progressOrder.id){
            progressOrder.num = event.num;
          }
          print("tuWenNum3:${progressOrder.num}");
        }
      });
    });
  }


  @override
  void dispose() {
    exitLogin.cancel();
}

  @override
  void deactivate() {
    _getOrderInProgress();
  }
  getNum(List<ProgressOrder> progressOrderList) async {
//    print("tuWenNum4:开始查询");

    for (ProgressOrder progressOrder in progressOrderList) {
//      print("tuWenNum4:${tuwenOrder.id}");
      OrderNum orderNum = await db.getOrder(progressOrder.id);
      //print("数据库5:${orderNum.orderId??''}");
      setState(() {
        if(orderNum != null){
          progressOrder.num = orderNum.num??"";
        }

      });

//      print("tuWenNum4:${tuwenOrder.num}");
    }
  }

  _getOrderInProgress() {
    DioUtils.instance.requestNetwork<ProgressOrder>(
        Method.get, Api.GETORDERINPROGRESS,isList: true, onSuccessList: (data) {
      setState(() {
        progressOrderList = data;
        isShowLoading = false;
        getNum(progressOrderList);
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
        : progressOrderList.length == 0
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
                      itemCount: progressOrderList.length,
                      itemBuilder: (context, index) {
                        return _buildItem(index, progressOrderList[index].num,
                            progressOrderList[index].num == "0"||progressOrderList[index].num == "");
                      }),
                ],
              );
  }

  _buildItem(int index, String num, bool offstage) {
    return GestureDetector(
        onTap: () {
          Router.push(context, Router.talk,
              {'orderId': progressOrderList[index].id, 'offstage': false,'type':progressOrderList[index].type});
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
                        progressOrderList[index].doctorImage == null?AssetImage('assets/images/beijing2.jpg'):NetworkImage(progressOrderList[index].doctorImage),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            progressOrderList[index].doctorName ?? "",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            progressOrderList[index].createTime ?? "",
                            style: TextStyle(color: Colors.black26),
                          ),
                        ],)
                      ),
                      Text('图文订单',style: TextStyle(color: Colors.black26),)
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
}
