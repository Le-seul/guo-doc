import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_center_bean.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/my_card.dart';

class ServiceChild extends StatefulWidget {
  String location = '';
  ServiceChild(@required this.location);

  @override
  _ServiceChildState createState() => _ServiceChildState();
}

class _ServiceChildState extends State<ServiceChild> {
  List<ServCenter> list = List();
  bool offstage = true;
  bool isShowLoading = true;

  @override
  void initState() {
    _getServiceCenter();
  }

  _getServiceCenter() {
    DioUtils.instance
        .requestNetwork<ServCenter>(Method.get, Api.GETPSYSERVICECENTERLIST,
            queryParameters: {
              'location': widget.location,
            },
            isList: true, onSuccessList: (data) {
      setState(() {
        list = data;
        isShowLoading = false;
//        print('获取服务中心成功!');
      });
    }, onError: (code, msg) {
      setState(() {
//        print('获取服务中心失败!');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isShowLoading
        ? LoadingWidget.childWidget()
        : list.length == 0
            ? Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Text('暂无数据'),
              )
            : Container(
                child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) => _buildItem(index),
              ));
  }

  _buildItem(index) {
    return Container(
      margin: EdgeInsets.only(
          left: 15, right: 15, bottom: 15, top: index == 0 ? 15 : 0),
      child: MyCard(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Router.pushNoParams(context, Router.center_detail);
                },
                child: Container(
                  color: Colors.white,

                  child: Row(
                    children: <Widget>[
                      Image.network(list[index].imgId, height: 40, width: 40),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(list[index].name),
                          SizedBox(
                            height: 8,
                          ),
                          Flex(
                            direction: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 15,
                                color: Colors.black26,
                              ),
                              Expanded(
                                child: Text(
                                  list[index].remark,
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Row(
                                children: <Widget>[
                                  list[index].serviceStation.length == 0
                                      ? Text('')
                                      : Text(
                                          '心理服务站 ${list[index].serviceStation.length}   ',
                                          style:
                                              TextStyle(color: Colors.black26)),
                                  Text('休闲驿站 2',
                                      style: TextStyle(color: Colors.black26)),
                                ],
                              )),
                              GestureDetector(
                                child: list[index].offstage
                                    ? Row(
                                        children: <Widget>[
                                          Text('展开'),
                                          Icon(Icons.arrow_drop_down)
                                        ],
                                      )
                                    : Row(
                                        children: <Widget>[
                                          Text('收起'),
                                          Icon(Icons.arrow_drop_up)
                                        ],
                                      ),
                                onTap: () {
                                  setState(() {
                                    list[index].offstage =
                                        !list[index].offstage;
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Offstage(
                offstage: list[index].offstage,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list[index].serviceStation.length,
                  itemBuilder: (context, index2) =>
                      _buildChild(list[index].serviceStation[index2]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildChild(ServiceStation serviceStation) {
    return GestureDetector(
      onTap: () {
        Router.pushNoParams(context, Router.center_detail);
      },
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 1,
              color: Colors.black26,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(serviceStation.name)),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 15,
                    color: Colors.black26,
                  ),
                  Expanded(
                    child: Text(
                      serviceStation.remark,
                      style: TextStyle(color: Colors.black26),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
