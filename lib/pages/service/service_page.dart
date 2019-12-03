import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/chunyu_message.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:flutter_first/bean/service_activity_entity.dart';
import 'package:flutter_first/block/bloc_provider.dart';
import 'package:flutter_first/block/chunyu_bloc.dart';
import 'package:flutter_first/db/order_db.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/doctor/graphic_consuitation.dart';
import 'package:flutter_first/pages/home/doctor/history_record.dart';
import 'package:flutter_first/pages/home/doctor/telephone_consultation.dart';
import 'package:flutter_first/pages/service/servicenext/activity.dart';
import 'package:flutter_first/pages/service/servicenext/activity_list.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  int day1,day2,day3,hour1,hour2,hour3,min1,min2,min3,sec1,sec2,sec3;
  List<ServiceActivity> serviceActivityList = List();
  static Timer _timer; //倒计时的计时器
  int orderCount = 0;
  String tuWenNum = '';
  String fastPhone = '';
  var db = OrderDb();

  @override
  void initState() {
    _requestActivity();
    init();
  }

  @override
  void dispose() {
    _timer.cancel();
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
          intFastPhone = int.parse(orderNum.num) + intFastPhone;
          fastPhone = "$intFastPhone";
        }
      });
    }
//    print("fastPhone:$intFastPhone");
  }

  void _requestActivity() {
   DioUtils.instance.requestNetwork<ServiceActivity>(
       Method.get,
       Api.GETACTIVITIES,
       queryParameters: {"pageSize": 1, "pageNumber": 1},
       isList: true,
       onSuccessList: (data) {
         setState(() {
           serviceActivityList = data;
           startTimer(DateTime(2019,12,1));
           print('活动详情请求成功！');
         });
       },
       onError: (code, msg) {
         Toast.show('活动详情请求失败！');
       });
 }

  @override
  Widget build(BuildContext context) {
    final ChunyuPushBloc bloc = BlocProvider.of<ChunyuPushBloc>(context);
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return Scaffold(
      backgroundColor: Colours.line,
      appBar: AppBar(
        title: Text(
          '服务',
        ),
        centerTitle: true,
        backgroundColor: Colours.bg_green,
        elevation: 0,
      ),
      body: SafeArea(
          child: ListView(
            physics: ClampingScrollPhysics(),

            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(

                    child:Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: ScreenUtil().setHeight(16),
                          color: Colours.bg_green,                        ),
                        Container(
                          width: double.infinity,
                          height: ScreenUtil().setHeight(12),
                          color: Colours.line,
                        ),
                      ],
                    )



                  ),

                  Positioned(
                    top: 0,
                    //left: 10,
                    child: Container(
                    padding:EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),bottom: 15 ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          height: ScreenUtil().setHeight(3),
                          width: ScreenUtil().setWidth(1.2),
                        ),
                        Text('   在线问诊',style: TextStyle(fontSize: 16.5,color: Colors.white),)
                      ],
                    ),),),
                  Positioned(
                    top: 50,
                      left: 18,
                      child: Container(
                       padding: EdgeInsets.only(top: 15,bottom: 15),
                        width: ScreenUtil().setWidth(90),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Center(
                          child: StreamBuilder<ChunyuMessage>(
                            stream: bloc.stream,
                            builder: (BuildContext context,
                                AsyncSnapshot<ChunyuMessage> snapshot) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _itemWidget('assets/images/service/图.png','图文问诊', snapshot.hasData?(snapshot.data.tuwenNum == 0):(tuWenNum == '0'||tuWenNum == ''),snapshot.hasData?"${snapshot.data.tuwenNum}":tuWenNum),
                                  _itemWidget('assets/images/service/电话.png','电话问诊',snapshot.hasData?(snapshot.data.fastPhoneNum == 0):(fastPhone == '0'||fastPhone == ''),snapshot.hasData?"${snapshot.data.fastPhoneNum}":fastPhone),
                                  _itemWidget('assets/images/service/钟.png','历史咨询',true,'1')

                                ],
                              );
                            },
                          )
                        ),
                      ))
                ],
              ),
              Container(
                padding:EdgeInsets.only(top: 0,left:ScreenUtil().setWidth(5), ),
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Color(0xff2AA586),
                      height: ScreenUtil().setHeight(3),
                      width: ScreenUtil().setWidth(1.2),
                    ),
                    GestureDetector(
                      onTap: (){
                      },
                        child: Text('   活动参与',style: TextStyle(fontSize: 16.5),)),

                  ],
                ),),
              InkWell(
                child: Container(
                  margin:EdgeInsets.fromLTRB(ScreenUtil().setWidth(5),ScreenUtil().setWidth(5),ScreenUtil().setWidth(5),0),
                  height: ScreenUtil().setHeight(40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height:ScreenUtil().setHeight(25),
                        margin: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: NetworkImage('https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2530389104,3227160503&fm=26&gp=0.jpg'),fit: BoxFit.fill)
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child:
                          Container(
                            height: ScreenUtil().setHeight(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(bottom:Radius.circular(10)),
                              color: Colors.black54,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text('距结束 ',style: TextStyle(color: Colors.white)),
                                  Container(
                                      height: ScreenUtil().setHeight(3),
                                      width: ScreenUtil().setHeight(4.5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Center(
                                        child: Text(day1.toString(),style: TextStyle(color: Colors.grey.shade600),),
                                      )
                                  ),
                                  Text(' 天 ',style: TextStyle(color: Colors.white)),
                                  Container(
                                      height: ScreenUtil().setHeight(3),
                                      width: ScreenUtil().setHeight(3),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Center(
                                        child: Text(hour1.toString(),style: TextStyle(color: Colors.grey.shade600),),
                                      )
                                  ),
                                  Text(' 时 ',style: TextStyle(color: Colors.white)),
                                  Container(
                                      height: ScreenUtil().setHeight(3),
                                      width: ScreenUtil().setHeight(3),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Center(
                                        child: Text(min1.toString(),style: TextStyle(color: Colors.grey.shade600),),
                                      )
                                  ),
                                  Text(' 分 ',style: TextStyle(color: Colors.white)),
                                  Container(
                                      height: ScreenUtil().setHeight(3),
                                      width: ScreenUtil().setHeight(3),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Center(
                                        child: Text(sec1.toString(),style: TextStyle(color: Colors.grey.shade600),),
                                      )
                                  ),
                                  Text(' 秒 ',style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 13),
                          child: Text('北京中日友好医院活动',style: TextStyle(fontSize: 14),)),
                      Container(
                        margin: EdgeInsets.only(left: 13,top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                  text:'25',
                                  style: TextStyle(color: Colors.orange,fontSize: 12),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '人已报名',
                                      style: TextStyle(color: Colors.black54,fontSize: 12),
                                    )
                                  ]
                              ),

                            ),
                            Container(
                                margin: EdgeInsets.only(right: 15),
                                width: 80,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  color: Color(0xff2AA586),
                                ),
                                child: Center(
                                  child: Text('活动进行中',style: TextStyle(color: Colors.white,fontSize: 12),),
                                )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: (){
                  NavigatorUtil.pushPage(context,ActivityListPage());
                },
              ),
              InkWell(
                child: Container(
                  margin:EdgeInsets.fromLTRB(ScreenUtil().setWidth(5),ScreenUtil().setWidth(5),ScreenUtil().setWidth(5),0),
                  height: ScreenUtil().setHeight(40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height:ScreenUtil().setHeight(25),
                        margin: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: NetworkImage('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572950573293&di=a8fb6c7d13a769a3a5197398e3c8d6c0&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F10%2F92%2F12%2F83D58PIC3Ah.jpg'),fit: BoxFit.fill)
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child:
                          Container(
                            height: ScreenUtil().setHeight(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(bottom:Radius.circular(10)),
                              color: Colors.black54,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text('距结束 ',style: TextStyle(color: Colors.white)),
                                  Container(
                                      height: ScreenUtil().setHeight(3),
                                      width: ScreenUtil().setHeight(4.5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Center(
                                        child: Text('132',style: TextStyle(color: Colors.grey.shade600),),
                                      )
                                  ),
                                  Text(' 天 ',style: TextStyle(color: Colors.white)),
                                  Container(
                                      height: ScreenUtil().setHeight(3),
                                      width: ScreenUtil().setHeight(3),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Center(
                                        child: Text('07',style: TextStyle(color: Colors.grey.shade600),),
                                      )
                                  ),
                                  Text(' 时 ',style: TextStyle(color: Colors.white)),
                                  Container(
                                      height: ScreenUtil().setHeight(3),
                                      width: ScreenUtil().setHeight(3),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Center(
                                        child: Text('46',style: TextStyle(color: Colors.grey.shade600),),
                                      )
                                  ),
                                  Text(' 分 ',style: TextStyle(color: Colors.white)),
                                  Container(
                                      height: ScreenUtil().setHeight(3),
                                      width: ScreenUtil().setHeight(3),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Center(
                                        child: Text(sec1.toString(),style: TextStyle(color: Colors.grey.shade600),),
                                      )
                                  ),
                                  Text(' 秒 ',style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 13),
                          child: Text('北京中日友好医院活动',style: TextStyle(fontSize: 14),)),
                      Container(
                        margin: EdgeInsets.only(left: 13,top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                  text:'25',
                                  style: TextStyle(color: Colors.orange,fontSize: 12),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '人已报名',
                                      style: TextStyle(color: Colors.black54,fontSize: 12),
                                    )
                                  ]
                              ),

                            ),
                            Container(
                                margin: EdgeInsets.only(right: 15),
                                width: 80,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  color: Color(0xffF6A744),
                                ),
                                child: Center(
                                  child: Text('即将开始',style: TextStyle(color: Colors.white,fontSize: 12),),
                                )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: (){
                  NavigatorUtil.pushPage(context,ActivityListPage());
                },
              ),
              InkWell(
                child: Container(
                  margin:EdgeInsets.fromLTRB(ScreenUtil().setWidth(5),ScreenUtil().setWidth(5),ScreenUtil().setWidth(5),0),
                  height: ScreenUtil().setHeight(40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height:ScreenUtil().setHeight(25),
                        margin: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: NetworkImage('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572950527165&di=92bdaf54b0a99baf5aef77fbdab726f1&imgtype=0&src=http%3A%2F%2Fimg.redocn.com%2Fsheying%2F20141023%2Fsanyayalongwanyouyongchangtupian_3306611.jpg'),fit: BoxFit.fill)
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child:
                          Container(
                            height: ScreenUtil().setHeight(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(bottom:Radius.circular(10)),
                              color: Colors.black54,
                            ),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('25人参与活动',style: TextStyle(color: Colors.grey.shade200),)
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 13),
                          child: Text('北京中日友好医院活动',style: TextStyle(fontSize: 14),)),
                      Container(
                        margin: EdgeInsets.only(left: 13,top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                  text:'25',
                                  style: TextStyle(color: Colors.orange,fontSize: 12),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '人已报名',
                                      style: TextStyle(color: Colors.black54,fontSize: 12),
                                    )
                                  ]
                              ),

                            ),
                            Container(
                                margin: EdgeInsets.only(right: 15),
                                width: 80,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  color: Color(0xffC6C6C6),
                                ),
                                child: Center(
                                  child: Text('活动已结束',style: TextStyle(color: Colors.white,fontSize: 12),),
                                )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: (){
                  NavigatorUtil.pushPage(context,ActivityListPage());
                },
              ),


            ],
          )
      ),
    );
  }


  _itemWidget(String url,String name,bool offstage,String count){
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Center(
                    child: Image.asset(url,height: 60,width: 60,fit: BoxFit.fill,),
                  ),
                  onTap: (){
                    NavigatorUtil.pushPage(context,HistoryRecord());
                  },
                ),
                SizedBox(height: 10,),
                Text(name,style: TextStyle(fontSize: 12),)
              ],
            ),
            Offstage(
              offstage: offstage,
              child: Container(
                padding: EdgeInsets.only(right: 2),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding:
                    EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
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
            )
          ],
        ),
      ),
    );
  }


  void startTimer(DateTime stopDate) {

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        var today = DateTime.now();
        //DateTime stop = today.add(Duration(days: 5));
        //print("today$today");
        var data1 = today.millisecondsSinceEpoch;
        var data2 = stopDate.millisecondsSinceEpoch;
        var diffience = data2 - data1;
        diffience>0?null:diffience=0;
//        print("data:$data1");
        day1 = diffience~/86400000;
        var dif2 =diffience - day1*86400000;
        hour1 = dif2~/3600000;
        var dif3 =diffience - day1*86400000-hour1*3600000;
        min1 = dif3~/60000;
        var dif4 =diffience - day1*86400000-hour1*3600000-min1*60000;
        sec1 = dif4~/1000;

//        print("day$day1");
//        print("hour$hour1");
//        print("fen$min1");
//        print("miao$sec1");
      });

    });
  }


}