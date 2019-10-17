import 'package:flutter/material.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset('assets/images/myBackground.png'),
              Positioned(
                top: 0,
                left: ScreenUtil().setWidth(45),
                child: Text('我的',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
              Positioned(
                top: ScreenUtil().setHeight(5),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage('https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2080823830,3911438045&fm=26&gp=0.jpg'))),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('张警官',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        Text('189*****111',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Image.asset('assets/images/erweima.png'),
                    )
                  ],
                ),
              ),
              Positioned(
                top: ScreenUtil().setHeight(20),
                left: ScreenUtil().setWidth(5),
                child: Container(
                  height: ScreenUtil().setHeight(25),
                  width: ScreenUtil().setWidth(90),
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        //健康运动步数
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
                          ),
                          Expanded(
                              flex: 1,
                              child: InkWell(
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
                                  onTap: () {
                                    Router.pushNoParams(
                                        context, Router.step_ranking);
                                  })),
                          Expanded(
                              flex: 1,
                              child: InkWell(
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
                                onTap: () {
                                  Router.pushNoParams(
                                      context, Router.step_ranking);
                                },
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        height: 1,
                        child: Container(
                          color: Colors.black12,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                height: 60,
                                width: 40,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/mine/我的收藏.png',
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      '我的收藏',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                              onTap: (){

                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: (){
                              },
                              child: Container(
                                height: 60,
                                width: 40,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/mine/我的步数.png',
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      '我的步数',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                height: 60,
                                width: 40,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/mine/我的活动.png',
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      '我的活动',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                height: 60,
                                width: 40,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/mine/消息通知.png',
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      '消息通知',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          FlatButton(
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/体检报告.png',
                      height: 25,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '    体检报告',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/箭头.png',
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              Router.pushNoParams(context, Router.reporylist);
            },
          ), // 体检报告
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/健康咨询.png',
                      height: 25,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '    健康咨询',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/箭头.png',
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ), //健康咨询
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/慢病评估.png',
                      height: 25,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '    慢病评估',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/箭头.png',
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ), //慢病评估
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/问卷量表.png',
                      height: 25,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '    问卷量表',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/箭头.png',
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ), //问卷调查
          SizedBox(
            height: 9,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/意见建议.png',
                      height: 25,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '    意见建议',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/箭头.png',
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ), //意见建议
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/联系我们.png',
                      height: 25,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '    联系我们',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/箭头.png',
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ), //联系我们
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/隐私服务.png',
                      height: 25,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '    隐私服务条款',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/箭头.png',
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ), //隐私服务条款
          SizedBox(
            height: 7,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/绑定微信.png',
                      height: 25,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '    绑定微信',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/箭头.png',
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ), //绑定微信
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          FlatButton(
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/系统设置.png',
                      height: 25,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: GestureDetector(
                      child: Text(
                        '    系统设置',
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        Router.pushNoParams(context, Router.exitLoginPage);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/mine/箭头.png',
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ), //系统设置
        ],
      ),
    );
  }
}
