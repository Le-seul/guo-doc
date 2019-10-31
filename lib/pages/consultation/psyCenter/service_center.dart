import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_center.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCenterPage extends StatefulWidget {
  @override
  _ServiceCenterPageState createState() => _ServiceCenterPageState();
}

class _ServiceCenterPageState extends State<ServiceCenterPage> {
  List<PsyServiceCenter> ServiceList = List();
  List<PsyServiceCenter> TypeList = List();
  bool isShowLoading = true; //\
  String type = "心理服务分中心";

  void initState() {
    super.initState();
    _requestPsyServiceCenterList();
    _requestPsyServiceCenterByType();
  }

  @override
  void _requestPsyServiceCenterList() {
    DioUtils.instance.requestNetwork<PsyServiceCenter>(Method.get, Api.PsyServiceCenterList,
        isList: true, onSuccessList: (data) {
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
        Method.get,
        Api.PsyServiceCenterByType,
        queryParameters: {"type": type},
        isList: true, onSuccessList: (data) {
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
      body: ListView(
        children: <Widget>[
          SearchTextFieldWidget(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
            color: Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: ScreenUtil().setHeight(9),
                  margin: EdgeInsets.fromLTRB(15, 0, 6, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white,
                            Colors.lightBlueAccent,
                          ])),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenUtil().setHeight(2),
                            ),
                            Image.asset(
                              'assets/images/consultation/房子.png',
                              height: 25,
                            ),
                            SizedBox(
                              width: ScreenUtil().setHeight(1),
                            ),
                            Text(
                              '心理服务分中心',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        onTap: () {
                          Router.pushNoParams(
                              context, Router.psychologicalServiceCenterPage);
                          type ="心理服务分中心";
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: ScreenUtil().setHeight(9),
                      margin: EdgeInsets.fromLTRB(6, 0, 15, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.white,
                                Colors.greenAccent,
                              ])),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: ScreenUtil().setHeight(2),
                              ),
                              Image.asset(
                                'assets/images/consultation/搜索.png',
                                height: 25,
                              ),
                              SizedBox(
                                width: ScreenUtil().setHeight(1),
                              ),
                              Text(
                                '按地区查找',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      Router.pushNoParams(context, Router.locationsearch);
                    },
                  )
              ),

            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(2),
          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  height: ScreenUtil().setHeight(9),
//                  margin: EdgeInsets.fromLTRB(15, 0, 6, 0),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.all(Radius.circular(10)),
//                      gradient: LinearGradient(
//                          begin: Alignment.centerLeft,
//                          end: Alignment.centerRight,
//                          colors: [
//                            Colors.white,
//                            Colors.orangeAccent,
//                          ])),
//                  child: Row(
//                    children: <Widget>[
//                      InkWell(
//                        child: Row(
//                          children: <Widget>[
//                            SizedBox(
//                              width: ScreenUtil().setHeight(2),
//                            ),
//                            Image.asset(
//                              'assets/images/consultation/咖啡.png',
//                              height: 25,
//                            ),
//                            SizedBox(
//                              width: ScreenUtil().setHeight(1),
//                            ),
//                            Text(
//                              '休闲驿站',
//                              style: TextStyle(color: Colors.black54),
//                            ),
//                          ],
//                        ),
//                        onTap: (){
//                          setState(() {
//                            type='休闲驿站';
//                            _requestPsyServiceCenterByType();
//                          });
//                        },
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Expanded(
//                child: Container(
//                  height: ScreenUtil().setHeight(9),
//                  margin: EdgeInsets.fromLTRB(6, 0, 15, 0),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.all(Radius.circular(10)),
//                      gradient: LinearGradient(
//                          begin: Alignment.centerLeft,
//                          end: Alignment.centerRight,
//                          colors: [
//                            Colors.white,
//                            Colors.pinkAccent,
//                          ])),
//                  child: Row(
//                    children: <Widget>[
//                      InkWell(
//                          child: Row(
//                            children: <Widget>[
//                              SizedBox(
//                                width: ScreenUtil().setHeight(2),
//                              ),
//                              Image.asset(
//                                'assets/images/consultation/蛋糕.png',
//                                height: 25,
//                                color: Colors.pinkAccent,
//                              ),
//                              SizedBox(
//                                width: ScreenUtil().setHeight(1),
//                              ),
//                              Text(
//                                '心理服务站',
//                                style: TextStyle(color: Colors.black54),
//                              ),
//                            ],
//                          ),
//                          onTap: (){
//                            setState(() {
//                              type='服务站';
//                              _requestPsyServiceCenterByType();
//                            });
//                          }
//
//                      )
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),
          SizedBox(
            height: ScreenUtil().setHeight(2),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
            padding: EdgeInsets.fromLTRB(10,0,10,10),
            height: ScreenUtil().setHeight(70),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child:isShowLoading
                ? LoadingWidget.childWidget()
                : (ServiceList.length == 0)
                ? Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Text('暂无数据'),
            ) :
            ListView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: ServiceList.length,
              itemBuilder: (context,index){
                return Column(
                  children: <Widget>[
                    index==0?SizedBox(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '共 ${ServiceList.length} 家医院',
                            style: TextStyle(fontSize: 17),
                          ),
                          Icon(
                            Icons.art_track,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    height: 30,):SizedBox(),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 12),
                      height: 1,
                      color: Colours.line,
                    ),
                    Container(
                      height: ScreenUtil().setHeight(11),
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            ServiceList[index].imgId,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                ServiceList[index].name,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                ServiceList[index].shortDesc+"  |  "+ServiceList[index].location+"区  |  "+ServiceList[index].remark,
                                style:
                                TextStyle(color: Colors.grey, fontSize: 13.5),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
