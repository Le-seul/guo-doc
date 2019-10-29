import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/all_order_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
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
  List<FastphoneOrder> fastphoneOrder = List();
  List<TuwenOrder> tuwenOrder = List();
  AllOrder allOrder = new AllOrder();

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
    DioUtils.instance.requestNetwork<AllOrder>(
        Method.get, Api.GETALLORDER, onSuccess: (data) {
      setState(() {
        allOrder = data;
        fastphoneOrder = data.fastphoneOrder;
        tuwenOrder = data.tuwenOrder;
        isShowLoading = false;
        print("data:${json.encode(data)}");
        print("allOrder.tuwenOrder.length:${allOrder.tuwenOrder.length}");
        print('获取历史订单成功！');
      });
    }, onError: (code, msg) {
      setState(() {
        print('获取历史订单失败!');
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
                        Text('图文咨询'),
                        Text('电话咨询'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('其他服务'),
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
                        isShowLoading
                            ? LoadingWidget.childWidget()
                            : allOrder.tuwenOrder.length == 0
                            ? Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: Text('暂无数据'),
                        )
                            :  _buildWidget(0),
                        isShowLoading
                            ? LoadingWidget.childWidget()
                            :  allOrder.fastphoneOrder.length == 0
                            ? Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: Text('暂无数据'),
                        )
                            : _buildWidget(1),
                        _buildWidget(null),
                      ],
                    ),
                  )
                ],
              );
  }

  _buildWidget(int num) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: num == 0?allOrder.tuwenOrder.length:allOrder.fastphoneOrder.length,
      itemBuilder: (context, index) =>
          _buildItem(num == 0?allOrder.tuwenOrder[index]:allOrder.fastphoneOrder[index],num),
    );
  }

  _buildItem(var obj,int num) {
    TuwenOrder tuwenOrder;
    String id = "";
    FastphoneOrder fastphoneOrder;
    if(num == 0){
     tuwenOrder = obj;
     id = tuwenOrder.id;
    }else{
      fastphoneOrder = obj;
      id = fastphoneOrder.id;
    }
    return GestureDetector(
      onTap: () {
        Router.push(context, Router.talk,{'orderId': tuwenOrder.id, 'offstage': true});
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
                            num == 0?tuwenOrder.createTime:fastphoneOrder.createTime,
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
