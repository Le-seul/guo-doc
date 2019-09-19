import 'package:flutter/material.dart';
import 'package:flutter_first/util/router.dart';

  class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[

          
          Stack(
            children: <Widget>[
            Image.asset('assets/images/myBackground.png'),
              Positioned(
                top: 0,
                left: 160,
                child: Text('我的',style: TextStyle(color: Colors.white,fontSize: 18)),
              ),
              Positioned(
                top: 40,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20,),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/dangao.jpg'))
                      ),
                    ),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('张警官',style: TextStyle(color: Colors.white,fontSize: 18)),
                        Text('189*****111',style: TextStyle(color: Colors.white,fontSize: 15)),

                      ],
                    ),
                    SizedBox(width: 80,),
                    Container(
                      height: 70,
                      width: 70,
                      color: Colors.white,
                      child: Image.asset('assets/images/erweima.png'),
                    )

                  ],
                ),
              ),
              Positioned(
                top: 130,
                left: 30,
                child: Container(
                  height: 150,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(6.0)),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Row(
                        //健康运动步数
                        children: <Widget>[
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              flex: 4,
                              child: FlatButton(
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              '积分',
                                            ),
                                            Text(
                                              '768',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              '排名',
                                            ),
                                            Text(
                                              '5/100',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () {},
                              )),
                          SizedBox(
                            width: 7,
                          ),
                          Expanded(
                              flex: 4,
                              child: FlatButton(
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              '步数',
                                            ),
                                            Text(
                                              '12008',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 17,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              '排名',
                                            ),
                                            Text(
                                              '5/100',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () {},
                              )),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                        SizedBox(height: 4,),
                        SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.black12,
                          ),
                        ),
                        SizedBox(height: 8,),

                        Row(
                          children: <Widget>[
                           SizedBox(width: 5,),
                           Container(
                              padding: EdgeInsets.all(0),
                              height: 60,
                              child: Row(children: <Widget>[
                                SizedBox(width: 17,),
                                InkWell(
                                  child: Container(
                                    height: 60,
                                    width: 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[Image.asset('assets/images/xin.png',fit:BoxFit.fill,),
                                        Text('我的收藏',style: TextStyle(fontSize: 10),)],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 22,),
                                InkWell(
                                  child: Container(
                                    height: 60,
                                    width: 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[Image.asset('assets/images/qiche.png',fit:BoxFit.fill,),
                                        Text('我的步数',style: TextStyle(fontSize: 10),)],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 43,),
                                InkWell(
                                  child: Container(
                                    height: 60,
                                    width: 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[Image.asset('assets/images/naozhong.png',fit:BoxFit.fill,),
                                        Text('我的活动',style: TextStyle(fontSize: 10),)],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                InkWell(
                                  child: Container(
                                    height: 60,
                                    width: 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[Image.asset('assets/images/lingdang.png',fit:BoxFit.fill,),
                                        Text('消息提醒',style: TextStyle(fontSize: 10),)],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                           SizedBox(width: 5,),
                          ],
                        ),
                      ],
                    ),
                ),
              ),

          ],
          ),

          FlatButton(
            child:Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(flex:1 ,child:Image.asset('assets/images/duigou.png') ,),
                  Expanded(flex:5 ,child: Text('    体检报告',style: TextStyle(fontSize: 16),),),
                  Expanded(flex:1 ,child: Icon(Icons.arrow_forward_ios),),
                ],
              ),
            ) ,
            onPressed: (){
              Router.pushNoParams(context, Router.reporylist);
            },
          ),// 体检报告
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child:Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(flex:1 ,child:Image.asset('assets/images/duihua.png') ,),
                  Expanded(flex:5 ,child: Text('    健康咨询',style: TextStyle(fontSize: 16),),),
                  Expanded(flex:1 ,child: Icon(Icons.arrow_forward_ios),),
                ],
              ),
            ) ,
            onPressed: (){},
          ),//健康咨询
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child:Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(flex:1 ,child:Image.asset('assets/images/rili.png') ,),
                  Expanded(flex:5 ,child: Text('    慢病评估',style: TextStyle(fontSize: 16),),),
                  Expanded(flex:1 ,child: Icon(Icons.arrow_forward_ios),),
                ],
              ),
            ) ,
            onPressed: (){},
          ),//慢病评估
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child:Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(flex:1 ,child:Image.asset('assets/images/diaocha.png') ,),
                  Expanded(flex:5 ,child: Text('    问卷量表',style: TextStyle(fontSize: 16),),),
                  Expanded(flex:1 ,child: Icon(Icons.arrow_forward_ios),),
                ],
              ),
            ) ,
            onPressed: (){},
          ),//问卷调查
          SizedBox(
            height: 9,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child:Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(flex:1 ,child:Image.asset('assets/images/deng.png') ,),
                  Expanded(flex:5 ,child: Text('    意见建议',style: TextStyle(fontSize: 16),),),
                  Expanded(flex:1 ,child: Icon(Icons.arrow_forward_ios),),
                ],
              ),
            ) ,
            onPressed: (){},
          ),//意见建议
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child:Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(flex:1 ,child:Image.asset('assets/images/dianhua.png') ,),
                  Expanded(flex:5 ,child: Text('    联系我们',style: TextStyle(fontSize: 16),),),
                  Expanded(flex:1 ,child: Icon(Icons.arrow_forward_ios),),
                ],
              ),
            ) ,
            onPressed: (){},
          ),//联系我们
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child:Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(flex:1 ,child:Image.asset('assets/images/tanhao.png') ,),
                  Expanded(flex:5 ,child: Text('    隐私服务条款',style: TextStyle(fontSize: 16),),),
                  Expanded(flex:1 ,child: Icon(Icons.arrow_forward_ios),),
                ],
              ),
            ) ,
            onPressed: (){},
          ),//隐私服务条款
          SizedBox(
            height: 7,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child:Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(flex:1 ,child:Image.asset('assets/images/yun.png') ,),
                  Expanded(flex:5 ,child: Text('    绑定微信',style: TextStyle(fontSize: 16),),),
                  Expanded(flex:1 ,child: Icon(Icons.arrow_forward_ios),),
                ],
              ),
            ) ,
            onPressed: (){},
          ),//绑定微信
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child:Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(flex:1 ,child:Image.asset('assets/images/shezhi.png') ,),
                  Expanded(flex:5 ,child: Text('    系统设置',style: TextStyle(fontSize: 16),),),
                  Expanded(flex:1 ,child: Icon(Icons.arrow_forward_ios),),
                ],
              ),
            ) ,
            onPressed: (){},
          ),//系统设置

        ],
      ),
    );
  }
}
