import 'package:flutter/material.dart';

  class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[

          SizedBox(
            height: 3,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          Container(
            height: 60,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  flex: 3,
                  child: Image.network(
                    'http://pic.51yuansu.com/pic2/cover/00/32/66/5810fed3aa0df_610.jpg',
                    fit: BoxFit.fill,
                    height: 60,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text('张警官'), Text('189******09')],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/images/erweima.png'),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ), //用户信息
          Row(
            //健康运动步数
            children: <Widget>[
              SizedBox(
                width: 10,
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
                                  '768',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '积分',
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '5',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '排名',
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {},
                  )),
              SizedBox(
                width: 20,
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
                                  '12008',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '步数',
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '5',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '排名',
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {},
                  )),
              SizedBox(
                width: 10,
              ),
            ],
          ), //积分排名
          SizedBox(
            height: 9,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            height: 60,
            child: Row(children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Container(
                width: 73,
                child: FlatButton(
                  //padding: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Image.asset('assets/images/xin.png',fit:BoxFit.fill,),
                      Text('我的收藏',style: TextStyle(fontSize: 10),)],
                  ),

                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 73,
                child: FlatButton(
                  //padding: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Image.asset('assets/images/qiche.png',fit:BoxFit.fill,),
                      Text('我的步数',style: TextStyle(fontSize: 10),)],
                  ),

                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 73,
                child: FlatButton(
                  //padding: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Image.asset('assets/images/naozhong.png',fit:BoxFit.fill,),
                      Text('我的活动',style: TextStyle(fontSize: 10),)],
                  ),

                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 73,
                child: FlatButton(
                  //padding: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Image.asset('assets/images/lingdang.png',),
                      Text('消息提醒',style: TextStyle(fontSize: 10),)],
                  ),

                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ]),
          ),//4个小图标
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
                  Expanded(flex:1 ,child:Image.asset('assets/images/duigou.png') ,),
                  Expanded(flex:5 ,child: Text('    体检报告',style: TextStyle(fontSize: 16),),),
                  Expanded(flex:1 ,child: Icon(Icons.arrow_forward_ios),),
                ],
              ),
            ) ,
            onPressed: (){},
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
