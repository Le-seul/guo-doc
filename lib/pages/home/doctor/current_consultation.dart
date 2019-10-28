import 'package:flutter/material.dart';
import 'package:flutter_first/bean/all_order_entity.dart';
import 'package:flutter_first/bean/message.dart';
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
  AllOrder allOrder = new AllOrder();
  @override
  void initState() {
    _getOrderInProgress();
  }

  _getOrderInProgress() {
    DioUtils.instance.requestNetwork<AllOrder>(
        Method.get, Api.GETORDERINPROGRESS, onSuccess: (data) {
      setState(() {
        allOrder = data;
        isShowLoading = false;
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
            : Column(
                children: <Widget>[
                  ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allOrder.tuwenOrder.length ,
                      itemBuilder: (context, index) {
                        return _buildItem(index,);
                      }),
                  ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allOrder.fastphoneOrder.length,
                      itemBuilder: (context, index) {
                        return _buildItem1(index);
                      }),
                ],
              );
  }

  _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        Router.push(
          context,
          Router.talk,allOrder.tuwenOrder[index].id
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: MyCard(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage('assets/images/beijing2.jpg'),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      allOrder.tuwenOrder[index].doctorName??"",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      allOrder.tuwenOrder[index].createTime??"",
                      style: TextStyle(color: Colors.black26),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  _buildItem1(int index) {
    return GestureDetector(
      onTap: () {
        Router.push(
            context,
            Router.talk,allOrder.fastphoneOrder[index].id
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: MyCard(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage('assets/images/beijing2.jpg'),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      allOrder.fastphoneOrder[index].doctorName??"",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      allOrder.fastphoneOrder[index].createTime??"",
                      style: TextStyle(color: Colors.black26),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
