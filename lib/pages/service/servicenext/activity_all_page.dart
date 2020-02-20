import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_activity_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/service/servicenext/activity.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/my_card.dart';

class ActivityAll extends StatefulWidget {
  @override
  _ActivityAllState createState() => _ActivityAllState();
}

class _ActivityAllState extends State<ActivityAll> {
  List<ServiceActivity> serviceActivityList = List();
  bool isShowLoading = true;
  bool isRemind = false;

  @override
  void initState() {
    _getRegionActivity();
  }

  _getRegionActivity() {
    DioUtils.instance.requestNetwork<ServiceActivity>(
        Method.get, Api.GETACTIVITIES,
        queryParameters: {"pageNumber": 1, 'pageSize': 50},
        isList: true, onSuccessList: (data) {
      setState(() {
        serviceActivityList = data;
        isShowLoading = false;
      });
      print('请求活动列表成功！');
    }, onError: (code, msg) {
      print('请求活动列表失败！');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff2CA687),
        title: Text(
          '活动',
        ),
      ),
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : (serviceActivityList.isEmpty)
          ? Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text('暂无数据'),
      )
          : Container(
          padding: EdgeInsets.only(top: 10),
          color: Color(0xFFEEEEEE),
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: serviceActivityList.length,
            itemBuilder: (context, index) =>
                _buildItem(serviceActivityList[index]),
          )),
    );
  }

  _buildItem(ServiceActivity serviceActivity) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pushPage(
            context, ServiceActivityPage(activityId: serviceActivity.id));
      },
      child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: MyCard(
            child: Container(
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              serviceActivity.cover,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                serviceActivity.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    size: 15,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '时间：${serviceActivity.startTime.substring(0, serviceActivity.startTime.length - 3)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    size: 15,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    serviceActivity.location,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.perm_identity,
                                    size: 15,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '负责人：闫吉',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 2,
                    color: Color(0xFFEEEEEE),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
//                      GestureDetector(
//                        onTap: (){
//                          setState(() {
//                            isRemind = !isRemind;
//                          });
//                        },
//                        child: Icon(
//                          Icons.check_circle,
//                          size: 18,
//                          color: isRemind?Colors.red:Colors.black45,
//                        ),
//                      ),
//                      SizedBox(
//                        width: 10,
//                      ),
                      Expanded(
                          child: Text(
                        '',
                        style: TextStyle(fontSize: 12),
                      )),
                      Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, bottom: 6, top: 6),
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          '我要报名',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
