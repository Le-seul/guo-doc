import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/psyCenter/center_detail_page.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  var num = 100;
  @override
  void initState() {
    read();
  }

  void read() async {
    print('获取步数');
    final results = await FitKit.read(
      DataType.STEP_COUNT,
      DateTime.now().subtract(Duration(days: 5)),
      DateTime.now(),
    );
    print('获取步数1');

    num = results[0].value;
    print('获取步数num:$num');
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return Scaffold(
      //backgroundColor: Colours.line,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(50),
                color: Colours.bg_green,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(12),
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: ScreenUtil().setWidth(47),
                child: Text('我的',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
              Positioned(
                top: ScreenUtil().setHeight(10),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572862144&di=d3fabea17ef23e6434c8a3499bc74e3e&imgtype=jpg&er=1&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20181003%2F17%2F1538557769-tTlpNrusja.jpg'))),
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
                      width: 90,
                    ),
                    Stack(
                      alignment: FractionalOffset(0.5, 0.5),
                      children: <Widget>[
                        Opacity(
                          opacity: 0.5,
                          child: Container(
                            height: 30,
                            width: 30,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(4))),
                          ),
                        ),
                        Center(
                          child: Image.asset('assets/images/mine/字母.png',height: 20,width: 20),
                        )
                      ],
                    ),

                    SizedBox(
                      width: 10,
                    ),
                    Stack(
                      alignment: FractionalOffset(0.5, 0.5),
                      children: <Widget>[
                        Opacity(
                          opacity: 0.5,
                          child: Container(
                            height: 30,
                            width: 30,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(4))),
                          ),
                        ),
                        Center(
                          child: Image.asset('assets/images/mine/二维码.png',height: 20,width: 20),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: ScreenUtil().setHeight(22),
                  left: ScreenUtil().setWidth(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('$num',style: TextStyle(color: Colors.white,fontSize: 17),),
                          SizedBox(height: 5,),
                          Text('步数',style: TextStyle(color: Colors.white,fontSize: 16),)
                        ],
                      ),
                      SizedBox(
                        width: 70,
                        ),
                      Container(
                        width: 1,
                        height: 35,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      InkWell(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text('5',style: TextStyle(color: Colors.white,fontSize: 17),),
                              SizedBox(height: 5,),
                              Text('排名',style: TextStyle(color: Colors.white,fontSize: 16),)
                            ],
                          ),
                        ),
                        onTap: (){
                          Router.pushNoParams(
                                      context, Router.step_ranking);
                        },
                      )
                    ],
                  )),
              Positioned(
                top: ScreenUtil().setHeight(32),
                left: ScreenUtil().setWidth(5),
                child: Container(
                  height: ScreenUtil().setHeight(15),
                  width: ScreenUtil().setWidth(90),
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                      //阴影颜色
                        color: Colors.grey,
                        //阴影位置
                        offset: Offset(0, 0),
                        //越大越透明
                        blurRadius: 10.0,
                        //阴影模糊大小
                        spreadRadius: 1.0,)
                    ],

                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 12,
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
                                Router.pushNoParams(context, Router.service_center);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: (){
                                Router.pushNoParams(context, Router.psycourse);
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
                              onTap: (){
                                Router.pushNoParams(context, Router.instructor_demeanorPage);
                              },
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
                      height: 32,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '  体检报告',
                      style: TextStyle(fontSize: 15),
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
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '  我的问诊',
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
              Router.pushNoParams(context, Router.historyRecord);
            },
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
                      'assets/images/mine/问卷量表.png',
                      height: 25,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '  问卷量表',
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
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '  意见建议',
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
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '  联系我们',
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
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '  隐私服务',
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
              NavigatorUtil.pushPage(
                  context, PsyCenterDetail(id: 1,),);
            },
          ), //隐私服务
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
                      'assets/images/mine/绑定微信.png',
                      height: 25,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '  绑定微信',
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
                      'assets/images/mine/系统设置.png',
                      height: 25,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: GestureDetector(
                      child: Text(
                        '  系统设置',
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
