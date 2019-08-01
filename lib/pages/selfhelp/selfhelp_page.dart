import 'package:flutter/material.dart';


class SelfHelpPage extends StatelessWidget {
  const SelfHelpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.black54,
          height: 23,
          alignment: Alignment.center,
          child: Text(
            '自助',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ), //自助
        Container(
            color: Colors.white10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '  每日一测',
                  style: TextStyle(fontSize: 18),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FlatButton(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          color: Colors.white,
                          onPressed: () {},
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/tu0.jpg',
                                height: 70,
                              ),
                              Text(
                                '你是一个追求完美的人吗',
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FlatButton(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          color: Colors.white,
                          onPressed: () {},
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/tu1.jpg',
                                height: 70,
                              ),
                              Text(
                                '你是一个追求完美的人吗',
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FlatButton(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          color: Colors.white,
                          onPressed: () {},
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/tu2.jpg',
                                height: 70,
                              ),
                              Text(
                                '你是一个追求完美的人吗',
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FlatButton(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          color: Colors.white,
                          onPressed: () {},
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/tu1.jpg',
                                height: 70,
                              ),
                              Text(
                                '你是一个追求完美的人吗',
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ), //每日一测
                SizedBox(
                  height: 10,
                ),
                Text('  随手记', style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  height: 165,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {},
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
                                  onPressed: () {},
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
                                  onPressed: () {},
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
                ), //图标7个
                SizedBox(
                  height: 10,
                ),
                Text(
                  '  心理课程',
                  style: TextStyle(fontSize: 18),
                ),
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  '  简单共读',
                  style: TextStyle(fontSize: 18),
                ),
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  '  运动评估',
                  style: TextStyle(fontSize: 18),
                ), //运动评估
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            height: 90,
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            //color: Colors.grey,

                            child: FlatButton(
                              onPressed: () {},
                              child: Image.asset(
                                'assets/images/jiahao.png',
                                color: Colors.white,
                              ),
                            )),
                      ),
                      Expanded(
                          flex: 10,
                          child: FlatButton(
                            onPressed: () {},
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  Opacity(
                                    opacity: 0.5,
                                    child:ClipRRect(
                                      borderRadius:BorderRadius.circular(10) ,
                                      child: Container(

                                          decoration: BoxDecoration(
                                              color: Colors.yellow
                                          ),
                                          width: 65,
                                          height: 95,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[Text('6月23日',style: TextStyle(fontSize: 11),),
                                              Text('评估记录',style: TextStyle(fontSize: 11),)],
                                          )
                                      ) ,
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Opacity(
                                    opacity: 0.7,
                                    child:ClipRRect(
                                      borderRadius:BorderRadius.circular(10) ,
                                      child: Container(

                                          decoration: BoxDecoration(
                                              color: Colors.yellow
                                          ),
                                          width: 65,
                                          height: 95,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[Text('6月23日',style: TextStyle(fontSize: 11),),
                                              Text('评估记录',style: TextStyle(fontSize: 11),)],
                                          )
                                      ) ,
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Opacity(
                                    opacity: 0.9,
                                    child:ClipRRect(
                                      borderRadius:BorderRadius.circular(10) ,
                                      child: Container(

                                          decoration: BoxDecoration(
                                              color: Colors.yellow
                                          ),
                                          width: 65,
                                          height: 95,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[Text('6月23日',style: TextStyle(fontSize: 11),),
                                              Text('评估记录',style: TextStyle(fontSize: 11),)],
                                          )
                                      ) ,
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '  膳食评估',
                  style: TextStyle(fontSize: 18),
                ), //膳食评估
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            height: 90,
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            //color: Colors.grey,

                            child: FlatButton(
                              onPressed: () {},
                              child: Image.asset(
                                'assets/images/jiahao.png',
                                color: Colors.white,
                              ),
                            )),
                      ),
                      Expanded(
                          flex: 10,
                          child: FlatButton(
                            onPressed: () {},
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  Opacity(
                                    opacity: 0.5,
                                    child:ClipRRect(
                                      borderRadius:BorderRadius.circular(10) ,
                                      child: Container(

                                          decoration: BoxDecoration(
                                              color: Colors.greenAccent
                                          ),
                                          width: 65,
                                          height: 95,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[Text('6月23日',style: TextStyle(fontSize: 11),),
                                              Text('评估记录',style: TextStyle(fontSize: 11),)],
                                          )
                                      ) ,
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Opacity(
                                    opacity: 0.7,
                                    child:ClipRRect(
                                      borderRadius:BorderRadius.circular(10) ,
                                      child: Container(

                                          decoration: BoxDecoration(
                                              color: Colors.greenAccent
                                          ),
                                          width: 65,
                                          height: 95,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[Text('6月23日',style: TextStyle(fontSize: 11),),
                                              Text('评估记录',style: TextStyle(fontSize: 11),)],
                                          )
                                      ) ,
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Opacity(
                                    opacity: 0.9,
                                    child:ClipRRect(
                                      borderRadius:BorderRadius.circular(10) ,
                                      child: Container(

                                          decoration: BoxDecoration(
                                              color: Colors.greenAccent
                                          ),
                                          width: 65,
                                          height: 95,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[Text('6月23日',style: TextStyle(fontSize: 11),),
                                              Text('评估记录',style: TextStyle(fontSize: 11),)],
                                          )
                                      ) ,
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),//膳食评估记录
                SizedBox(
                  height: 20,
                ),
                Text(
                  '  运动评估',
                  style: TextStyle(fontSize: 18),
                ), //身体状况评估
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            height: 90,
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            //color: Colors.grey,

                            child: FlatButton(
                              onPressed: () {},
                              child: Image.asset(
                                'assets/images/jiahao.png',
                                color: Colors.white,
                              ),
                            )),
                      ),
                      Expanded(
                          flex: 10,
                          child: FlatButton(
                            onPressed: () {},
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  Opacity(
                                    opacity: 0.5,
                                    child:ClipRRect(
                                      borderRadius:BorderRadius.circular(10) ,
                                      child: Container(

                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey
                                          ),
                                          width: 65,
                                          height: 95,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[Text('6月23日',style: TextStyle(fontSize: 11),),
                                              Text('评估记录',style: TextStyle(fontSize: 11),)],
                                          )
                                      ) ,
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Opacity(
                                    opacity: 0.7,
                                    child:ClipRRect(
                                      borderRadius:BorderRadius.circular(10) ,
                                      child: Container(

                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey
                                          ),
                                          width: 65,
                                          height: 95,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[Text('6月23日',style: TextStyle(fontSize: 11),),
                                              Text('评估记录',style: TextStyle(fontSize: 11),)],
                                          )
                                      ) ,
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Opacity(
                                    opacity: 0.9,
                                    child:ClipRRect(
                                      borderRadius:BorderRadius.circular(10) ,
                                      child: Container(

                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey
                                          ),
                                          width: 65,
                                          height: 95,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[Text('6月23日',style: TextStyle(fontSize: 11),),
                                              Text('评估记录',style: TextStyle(fontSize: 11),)],
                                          )
                                      ) ,
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ), //运动评估记录
              ],
            )),
      ],
    );
  }
}
