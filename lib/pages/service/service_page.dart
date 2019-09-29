import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_activity_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/my_card.dart';

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
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 35,
              alignment: Alignment.center,
              child: Text(
                '服务',
                style: TextStyle(fontSize: 18,),
              ),
            ), //服务
            //心灵之约
            SizedBox(
              height: 2,
              child: Container(
                color: Colors.grey[200],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.grey[200],
              child: MyCard(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('心灵之约',style: TextStyle(fontSize: 17,fontWeight:FontWeight.w600),),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text('更多  ',style: TextStyle(color: Colors.grey),),
                                Image.asset('assets/images/service/箭头.png',height: 15,)
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Stack(
                                children: <Widget>[
                                  Image.network(
                                    'http://image.uczzd.cn/793049627461073302.jpg',
                                    height: 80,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 15,
                                      child: Image.asset('assets/images/service/等待中.png',
                                      height: 18,),
                                  )
                                ],
                              )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '2018年全局高位冠心病患者越来越多',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                            '2019-06-23',
                                            style: TextStyle(
                                                fontSize: 13, color: Colors.black26),
                                            textAlign: TextAlign.left,
                                          ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),//新闻一
                      SizedBox(height: 5,),
                      Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                flex: 4,
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(
                                      'http://image.uczzd.cn/793049627461073302.jpg',
                                      height: 80,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 15,
                                      child: Image.asset('assets/images/service/已结束.png',
                                        height: 18,),
                                    )
                                  ],
                                )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '2018年全局高位冠心病患者越来越多',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        '2019-06-23',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black26),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),//新闻二
                      SizedBox(height: 5,),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('发起咨询'),
                          SizedBox(width: 15,),
                          Text('咨询热线')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),//心灵之约
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.grey[200],
              child: MyCard(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('健康咨询',style: TextStyle(fontSize: 17,fontWeight:FontWeight.w600),),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text('更多  ',style: TextStyle(color: Colors.grey),),
                                Image.asset('assets/images/service/箭头.png',height: 15,)
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                flex: 4,
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(
                                      'http://image.uczzd.cn/793049627461073302.jpg',
                                      height: 80,
                                      fit: BoxFit.fitHeight,
                                    ),
//                                    Positioned(
//                                      top: 0,
//                                      right: 15,
//                                      child: Image.asset('assets/images/service/等待中.png',
//                                        height: 18,),
//                                    )
                                  ],
                                )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '2018年全局高位冠心病患者越来越多',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        '早起喝一杯凉白开,做深深的蹲坑运动',
                                        style: TextStyle(fontSize: 12, color: Colors.red),
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '2019-06-23',
                                            style: TextStyle(
                                                fontSize: 12, color: Colors.black26),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Image.asset('assets/images/service/对勾.png',height: 12,),
                                              Text(
                                                '个人信息',
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.green),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Image.asset('assets/images/service/对勾.png',height: 12,),
                                              Text(
                                                '体检报告',
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.green),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),//新闻一
                      SizedBox(height: 5,),
                      Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                flex: 4,
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(
                                      'http://image.uczzd.cn/793049627461073302.jpg',
                                      height: 80,
                                      fit: BoxFit.fitHeight,
                                    ),
//                                    Positioned(
//                                      top: 0,
//                                      right: 15,
//                                      child: Image.asset('assets/images/service/已结束.png',
//                                        height: 18,),
//                                    )
                                  ],
                                )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '2018年全局高位冠心病患者越来越多',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '2019-06-23',
                                            style: TextStyle(
                                                fontSize: 12, color: Colors.black26),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Image.asset('assets/images/service/对勾.png',height: 12,),
                                              Text(
                                                '个人信息',
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.green),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),//新闻二
                      SizedBox(height: 5,),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('发起咨询'),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ), //健康咨询
            Container(
                padding: EdgeInsets.all(15),
                color: Colors.grey[200],
                child:MyCard(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          height: 30,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('活动参与',style: TextStyle(fontSize: 17,fontWeight:FontWeight.w600),),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text('更多  ',style: TextStyle(color: Colors.grey),),
                                    Image.asset('assets/images/service/箭头.png',height: 15,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2,
                          child: Container(
                            color: Colors.grey[200],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: serviceActivityList.length,
                            itemBuilder: (context, index) => _buildItem(index),
                          ),
                        ),
                      ],
                    ))
            ), //活动参与


            //活动参与
          ],
        ),
      ),
    );
  }


  _buildItem(int index) {
    return GestureDetector(
        onTap: () {
          Router.push(context, Router.serviceActivityPage,{'offstage': false, 'activityId': serviceActivityList[index].id});
        },
        child: Container(
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: index == 0 ? 0 : 2,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                child: Image.network(
                  serviceActivityList[index].cover,
                  height: 150,
                  fit: BoxFit.fill,
                ),
                width: double.infinity,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        serviceActivityList[index].name,
                        overflow:  TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 13,),
                      ),
                    ),),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${serviceActivityList[index].signInCount}人报名',
                          style: TextStyle(color: Colors.black26, fontSize: 11,
                          ),
                        ),
                        Text(
                          '${serviceActivityList[index].signInCount}人参加',
                          style: TextStyle(color: Colors.black26, fontSize: 11),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 2.0,right: 2.0,top: 1.0, bottom: 1.0),
                          child: Text('进行中',
                            style: TextStyle(fontSize: 8, color: Colors.green),),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ],
          ),
        )
    );
  }




}