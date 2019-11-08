import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_activity_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

  List<ServiceActivity> serviceActivityList = List();

  @override
  void initState() {
    _requestActivity();
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
         });

       },
       onError: (code, msg) {

         Toast.show('请求失败！');
       });
 }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return Scaffold(
      backgroundColor: Colours.line,
      body: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(40),
                    color: Colours.bg_green,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(14 ),
                        color: Colours.line,
                      ),
                    ),
                  ),
                  Positioned(
                    left:ScreenUtil().setWidth(45) ,
                    top:10,
                      child: Text('服务',style: TextStyle(color: Colors.white,fontSize: 18),)),
                  Positioned(
                    top: 30,
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
                    top: 88,
                      left: 18,
                      child: Container(
                       height: ScreenUtil().setHeight(22),
                        width: ScreenUtil().setWidth(90),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(12),
                                  height: ScreenUtil().setHeight(12),
                                  width: ScreenUtil().setHeight(12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                  child: Center(
                                    child: Image.asset('assets/images/service/图.png',height: 40,width: 40,),
                                  ),
                                ),
                                Text('图文问诊')
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(12),
                                  height: ScreenUtil().setHeight(12),
                                  width: ScreenUtil().setHeight(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: Center(
                                    child: Image.asset('assets/images/service/电话.png',height: 40,width: 40,),
                                  ),
                                ),
                                Text('电话问诊')
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(12),
                                  height: ScreenUtil().setHeight(12),
                                  width: ScreenUtil().setHeight(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purple,
                                  ),
                                  child: Center(
                                    child: Image.asset('assets/images/service/钟.png',height: 40,width: 40,),
                                  ),
                                ),
                                Text('历史咨询')
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              ),
              Container(
                padding:EdgeInsets.only(top: 5,left:ScreenUtil().setWidth(5), ),
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colours.bg_green,
                      height: ScreenUtil().setHeight(3),
                      width: ScreenUtil().setWidth(1.2),
                    ),
                    Text('   活动参与',style: TextStyle(fontSize: 16.5),),
                    SizedBox(width: ScreenUtil().setWidth(57),),
                    Text('更多>',style: TextStyle(fontSize: 13.5,color: Colors.grey.shade600),),

                  ],
                ),),
              Container(
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
                                      child: Text('21',style: TextStyle(color: Colors.grey.shade600),),
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
                        child: Text('北京中日友好医院活动',style: TextStyle(fontSize: 16),)),
                    Container(
                      margin: EdgeInsets.only(left: 13,top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text:'25',
                              style: TextStyle(color: Colors.orange),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '人已报名',
                                  style: TextStyle(color: Colors.black54),
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
                              color: Colours.bg_green,
                            ),
                            child: Center(
                              child: Text('活动进行中',style: TextStyle(color: Colors.white70),),
                            )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
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
                                      child: Text('21',style: TextStyle(color: Colors.grey.shade600),),
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
                        child: Text('北京中日友好医院活动',style: TextStyle(fontSize: 16),)),
                    Container(
                      margin: EdgeInsets.only(left: 13,top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                text:'25',
                                style: TextStyle(color: Colors.orange),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '人已报名',
                                    style: TextStyle(color: Colors.black54),
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
                                color: Colors.orange.shade200,
                              ),
                              child: Center(
                                child: Text('即将开始',style: TextStyle(color: Colors.white70),),
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
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
                        child: Text('北京中日友好医院活动',style: TextStyle(fontSize: 16),)),
                    Container(
                      margin: EdgeInsets.only(left: 13,top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                text:'25',
                                style: TextStyle(color: Colors.orange),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '人已报名',
                                    style: TextStyle(color: Colors.black54),
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
                                color: Colors.grey,
                              ),
                              child: Center(
                                child: Text('活动已结束',style: TextStyle(color: Colors.white70),),
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }







}