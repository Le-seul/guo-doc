import 'package:flutter/material.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SelfHelpPage extends StatelessWidget {
  const SelfHelpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);
    return Scaffold(
      backgroundColor: Colours.line,
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            height:  ScreenUtil().setHeight(7),
            alignment: Alignment.center,
            child: Text(
              '自助',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ), //自助
          Container(
              color: Colours.line,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: ScreenUtil().setHeight(2),),
                  Text(
                    '  每日一测',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(2),),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              height:  ScreenUtil().setHeight(14),
                              width:ScreenUtil().setWidth(35),
                              decoration: BoxDecoration(
                                //image: DecorationImage(image: AssetImage('assets/images/tu0.jpg',),fit: BoxFit.fill),
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(flex: 4,child: Container(
                                  padding: EdgeInsets.fromLTRB(10,15,5,0),
                                  child: Text('你是一个追求完美的人么'),
                                ),),
                                Expanded(flex: 2,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('  关注 15197',style: TextStyle(color: Colors.grey),),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      alignment: Alignment.center,
                                      height: ScreenUtil().setHeight(3),
                                      width: ScreenUtil().setWidth(10),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.horizontal(left:Radius.circular(10) )
                                      ),
                                      child: Text('HOT',style: TextStyle(color: Colors.white,fontSize: 11),),
                                    )
                                  ],
                                ),)
                              ],
                            ) ,
                            ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          height:  ScreenUtil().setHeight(14),
                          width:ScreenUtil().setWidth(35),
                          decoration: BoxDecoration(
                            //image: DecorationImage(image: AssetImage('assets/images/tu0.jpg',),fit: BoxFit.fill),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(flex: 4,child: Container(
                                padding: EdgeInsets.fromLTRB(10,15,5,0),
                                child: Text('你是一个追求完美的人么'),
                              ),),
                              Expanded(flex: 2,child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('  关注 15197',style: TextStyle(color: Colors.grey),),
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    alignment: Alignment.center,
                                    height: ScreenUtil().setHeight(3),
                                    width: ScreenUtil().setWidth(10),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.horizontal(left:Radius.circular(10) )
                                    ),
                                    child: Text('HOT',style: TextStyle(color: Colors.white,fontSize: 11),),
                                  )
                                ],
                              ),)
                            ],
                          ) ,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          height:  ScreenUtil().setHeight(14),
                          width:ScreenUtil().setWidth(35),
                          decoration: BoxDecoration(
                            //image: DecorationImage(image: AssetImage('assets/images/tu0.jpg',),fit: BoxFit.fill),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(flex: 4,child: Container(
                                padding: EdgeInsets.fromLTRB(10,15,5,0),
                                child: Text('你是一个追求完美的人么'),
                              ),),
                              Expanded(flex: 2,child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('  关注 15197',style: TextStyle(color: Colors.grey),),
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    alignment: Alignment.center,
                                    height: ScreenUtil().setHeight(3),
                                    width: ScreenUtil().setWidth(10),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.horizontal(left:Radius.circular(10) )
                                    ),
                                    child: Text('HOT',style: TextStyle(color: Colors.white,fontSize: 11),),
                                  )
                                ],
                              ),)
                            ],
                          ) ,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          height:  ScreenUtil().setHeight(14),
                          width:ScreenUtil().setWidth(35),
                          decoration: BoxDecoration(
                            //image: DecorationImage(image: AssetImage('assets/images/tu0.jpg',),fit: BoxFit.fill),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(flex: 4,child: Container(
                                padding: EdgeInsets.fromLTRB(10,15,5,0),
                                child: Text('你是一个追求完美的人么'),
                              ),),
                              Expanded(flex: 2,child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('  关注 15197',style: TextStyle(color: Colors.grey),),
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    alignment: Alignment.center,
                                    height: ScreenUtil().setHeight(3),
                                    width: ScreenUtil().setWidth(10),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.horizontal(left:Radius.circular(10) )
                                    ),
                                    child: Text('HOT',style: TextStyle(color: Colors.white,fontSize: 11),),
                                  )
                                ],
                              ),)
                            ],
                          ) ,
                        ),


                      ],
                    ),
                  ), //每日一测
                  SizedBox(height: ScreenUtil().setHeight(2),),
                  Text('  随手记', style: TextStyle(fontSize: 18)),
                  Container(
                    margin:EdgeInsets.all(10) ,
                    height: ScreenUtil().setHeight(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Router.pushNoParams(context, Router.dietrecordsPage);
                                    },
                                    child: Image.asset(
                                      'assets/images/mifan.png',
                                      height: 60,
                                      width: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text('记饮食')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Router.pushNoParams(context, Router.sleepRecordsPage);

                                    },
                                    child: Image.asset(
                                      'assets/images/shuimian.png',
                                      height: 60,
                                      width: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text('记睡眠')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Router.pushNoParams(context, Router.movementClockPage);
                                    },
                                    child: Image.asset(
                                      'assets/images/paobu.png',
                                      height: 60,
                                      width: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text('运动打卡')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {},
                                    child: Image.asset(
                                      'assets/images/tizhongcheng.png',
                                      height: 60,
                                      width: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text('记体重')
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {},
                                  child: Image.asset(
                                    'assets/images/shizhong.png',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text('经期管理')
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {},
                                  child: Image.asset(
                                    'assets/images/lingdang.png',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text('用药提醒')
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {},
                                  child: Image.asset(
                                    'assets/images/aixin.png',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text('心情记录')
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ), //图标7个
                  SizedBox(height: ScreenUtil().setHeight(2),),
                  Text('  心理课程', style: TextStyle(fontSize: 18),),
                  SizedBox(height: ScreenUtil().setHeight(2),),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/beijing0.jpg'),
                                      fit: BoxFit.fill)),
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '怎么管理情绪',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '7天有效改善你的情绪',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 11),
                                      )
                                    ],
                                  )),
                            )), //课程1
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/beijing1.jpg'),
                                      fit: BoxFit.fill)),
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '如何缓解压力',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '7天内学会压力管理',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 11),
                                      )
                                    ],
                                  )),
                            )), //课程2
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/beijing2.jpg'),
                                      fit: BoxFit.fill)),
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '拯救你的不开心',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '15天破解抑郁烦恼',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 11),
                                      )
                                    ],
                                  )),
                            )), //课程3
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/beijing3.jpg'),
                                      fit: BoxFit.fill)),
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '怎么管理情绪',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '7天有效改善你的情绪',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 11),
                                      )
                                    ],
                                  )),
                            )), //课程4
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ), //小课程
                  SizedBox(height: ScreenUtil().setHeight(3),),
                  Text('  简单共读', style: TextStyle(fontSize: 18),),
                  SizedBox(height: ScreenUtil().setHeight(2),),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/beijing4.jpg'),
                                      fit: BoxFit.fill)),
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '怎么管理情绪',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '7天有效改善你的情绪',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 11),
                                      )
                                    ],
                                  )),
                            )), //课程1
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/beijing5.jpg'),
                                      fit: BoxFit.fill)),
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '如何缓解压力',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '7天内学会压力管理',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 11),
                                      )
                                    ],
                                  )),
                            )), //课程2
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/beijing6.jpg'),
                                      fit: BoxFit.fill)),
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '拯救你的不开心',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '15天破解抑郁烦恼',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 11),
                                      )
                                    ],
                                  )),
                            )), //课程3
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/beijing7.jpg'),
                                      fit: BoxFit.fill)),
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '怎么管理情绪',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '7天有效改善你的情绪',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 11),
                                      )
                                    ],
                                  )),
                            )), //课程4
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ), //简单共读课
                  SizedBox(height: ScreenUtil().setHeight(3),),
                  Text('  运动评估', style: TextStyle(fontSize: 18),),
                  SizedBox(height: ScreenUtil().setHeight(2),),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          height: ScreenUtil().setHeight(11),
                          width: ScreenUtil().setHeight(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('6月23日',style: TextStyle(color: Colors.grey),),
                              SizedBox(height: 3,),
                              Text('评估记录',style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          height: ScreenUtil().setHeight(11),
                          width: ScreenUtil().setHeight(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('6月23日',style: TextStyle(color: Colors.grey),),
                              SizedBox(height: 3,),
                              Text('评估记录',style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          height: ScreenUtil().setHeight(11),
                          width: ScreenUtil().setHeight(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('6月23日',style: TextStyle(color: Colors.grey),),
                              SizedBox(height: 3,),
                              Text('评估记录',style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          padding: EdgeInsets.fromLTRB(10, 20, 25, 20),
                          height: ScreenUtil().setHeight(11),
                          width: ScreenUtil().setHeight(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(left:Radius.circular(10) ),
                            color: Colors.greenAccent,
                          ),
                          child: Container(child: Image.asset('assets/images/圆加号.png',fit: BoxFit.fill,) ,)

                          ),


                      ],
                    ),
                  //运动评估

                ],
              )),
        ],
      ),
    );
  }
}
