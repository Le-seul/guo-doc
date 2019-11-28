import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/history_order_entity.dart';
import 'package:flutter_first/db/order_db.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/doctor/talk_page.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/my_card.dart';

class HistoryRecordWidget extends StatefulWidget {
  @override
  _HistoryRecordWidgetState createState() => _HistoryRecordWidgetState();
}

class _HistoryRecordWidgetState extends State<HistoryRecordWidget>
    with SingleTickerProviderStateMixin {
  TabController mController;
  bool isShowLoading = true;
  List<HistoryOrder> historyOrderList = List();
  List<HistoryOrder> fastphoneOrderList = List();
  List<HistoryOrder> tuwenOrderList = List();

  @override
  void initState() {
    super.initState();
    _getAllOrder();
    mController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  _getAllOrder() {
    DioUtils.instance.requestNetwork<HistoryOrder>(
        Method.get, Api.GETALLORDER,isList: true,onSuccessList: (data) {
      setState(() {
        historyOrderList = data;
        if(historyOrderList != null){
          for(HistoryOrder historyOrder in historyOrderList){
            if(historyOrder.type == 'tuwen'){
              tuwenOrderList.add(historyOrder);
            } else{
              fastphoneOrderList.add(historyOrder);
            }
          }
        }
        print('图文length:${tuwenOrderList.length}');
        print('电话length:${fastphoneOrderList.length}');
        isShowLoading = false;
        deleteOrderNum();
        print("data:${json.encode(data)}");
        print('获取历史订单成功！');
      });
    }, onError: (code, msg) {
      setState(() {
        print('获取历史订单失败!');
      });
    });
  }

  deleteOrderNum() async{
    var db = OrderDb();
    for(HistoryOrder historyOrder in historyOrderList){
      int id = await db.deleteOrder(historyOrder.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isShowLoading
        ? LoadingWidget.childWidget()
        : historyOrderList.isEmpty
            ? Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Text('暂无数据'),
              )
            : Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 38,
                    child: TabBar(
                      isScrollable: false,
                      //是否可以滚动
                      controller: mController,
                      indicatorColor: Color(0xff2CA687),
                      labelColor: Color(0xff2CA687),
                      unselectedLabelColor: Color(0xff666666),
                      labelStyle: TextStyle(fontSize: 16.0),
                      tabs: <Widget>[
                        Container(child: Text('图文咨询'),padding: EdgeInsets.only(top: 5),),
                        Container(child: Text('电话咨询'),padding: EdgeInsets.only(top: 5),),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('其他服务'),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: mController,
                      children: <Widget>[
                        isShowLoading
                            ? LoadingWidget.childWidget()
                            : tuwenOrderList.isEmpty
                            ? Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: Text('暂无数据'),
                        )
                            :  _buildWidget(tuwenOrderList),
                        isShowLoading
                            ? LoadingWidget.childWidget()
                            :  fastphoneOrderList.isEmpty
                            ? Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: Text('暂无数据'),
                        )
                            : _buildWidget(fastphoneOrderList),
                        Container(),
                      ],
                    ),
                  )
                ],
              );
  }

  _buildWidget(List<HistoryOrder> list) {
    print('length:$list');
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length??0,
      itemBuilder: (context, index) =>
          _buildItem(list[index]),
    );
  }

  _buildItem(HistoryOrder historyOrder) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pushPage(context,TalkPage(orderId: historyOrder.id,offstage: true,type: historyOrder.type,));
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: MyCard(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      child: ClipOval(
                        child: Image.network("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1935591139,4291919543&fm=26&gp=0.jpg",fit: BoxFit.fill,),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          "测试医生",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            historyOrder.createTime,
                          style: TextStyle(color: Colors.black26),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '已关闭',
                  style: TextStyle(color: Colors.black26),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
