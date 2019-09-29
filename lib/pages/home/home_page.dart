import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart' as lib1;
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/bean/banner.dart';
import 'package:flutter_first/bean/banner_model.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/search.dart';
import 'package:flutter_swiper/flutter_swiper.dart' as lib2;
import 'package:flutter_first/util/router.dart';

import 'package:flutter_first/pages/home/home_widgets/Table0Page.dart';
import 'package:flutter_first/pages/home/home_widgets/Table1Page.dart';
import 'package:flutter_first/mock_request.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../net/api.dart';
import '../../net/dio_utils.dart';

class HomePage extends StatefulWidget {



  HomePage({Key key,})
      : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  static String tu0;
//  static String tu1;
//  static String tu2;
  String registrationID;
  List<BannerModel> testList;
  List<BannerImage> bannerlist;
  List<ConsulationColumnsInfo> columnsInfoList = List();
  List TableList = [
    Table0(),
    Table1(),
  ];
  @override
  void initState() {
    _UpdateRegistrationID();
    _requestBanner();
    _getColumnsInfo();
  }

  void _UpdateRegistrationID() async{
    registrationID = await StorageManager.sharedPreferences.getString(Constant.registrationID);
    print('极光 id：$registrationID');
    if(registrationID!=null){
      DioUtils.instance.requestNetwork<String>(
          Method.post, Api.UPDATEREGISTRATIONID,
          queryParameters: {
            'deviceType': "android",
            'registrationID': registrationID,
          }, onSuccess: (data) {
        setState(() {
          print('上传registrationID成功!');
        });
      }, onError: (code, msg) {
        setState(() {
          print('上传registrationID失败!');
        });
      });
    }
  }

  void _getColumnsInfo() {
    DioUtils.instance.requestNetwork<ConsulationColumnsInfo>(
      Method.get,
      Api.GETAllCOlUMNINFO,
      queryParameters: {"columnId": 1, "pageSize": 3, "pageNumber": 1},
      isList: true,
      onSuccessList: (data) {
        setState(() {
          columnsInfoList.addAll(data);
        });
      },
      onError: (code, msg) {
        setState(() {
          Toast.show('请求失败');
        });
      },
    );
  }

  void _requestBanner() {
    DioUtils.instance.requestNetwork<BannerImage>(Method.get, Api.BANNER,
        isList: true, onSuccessList: (data) {
      setState(() {
        bannerlist = data;
      });
    }, onError: (code, msg) {
      print("sssss");
    });
  }

  Widget buildBanner(BuildContext context, List<BannerImage> list) {
    if (list == null) {
      return new Container(height: 0.0);
    }
    return new AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: lib1.Swiper(
        indicatorAlignment: AlignmentDirectional.topEnd,
        circular: true,
        interval: const Duration(seconds: 3),
        indicator: NumberSwiperIndicator(),
        children: list.map((model) {
          return new InkWell(
            onTap: () {
              Router.push(context, model.imgId, {'title': model.name});
            },
            child: new CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: model.imgId,
              placeholder: (context, url) => new ProgressView(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Container(
        color: Colours.bg_green,
        child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/back.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5,),
                    Row(
                      //扫码加搜索栏
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: SearchTextFieldWidget(
                              hintText: '请输入搜索内容',
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              onTab: () {},
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          height: 25,
                          child:loadAssetImage('scanning.png'),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 190,
                          child: buildBanner(context, bannerlist),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colours.bg_gray,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        //通知栏
                          padding: EdgeInsets.only(right: 8, left: 15),
                          height: 25,
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '公告',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                padding: EdgeInsets.only(
                                    top: 2, bottom: 2, right: 5, left: 5),
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '今年心理健康状况采集活动开始啦！',
                                style: TextStyle(fontSize: 13),
                              ),
                              Expanded(
                                  child: Align(
                                    child: loadAssetImage('arrow.png',height: 12,width: 12),
                                    alignment: Alignment.centerRight,
                                  ))
                            ],
                          )),
                      onTap: (){
                        Router.push(context, 'http://ygyd.aireading.top/ygyd/create?taskId=aaa&userId=1&scaleCode=10012&sex=0&age=1', {'title': '专业测评'});
                      },
                    ),
                     //消息通知
                    Padding(
                        //测评小表格
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Container(
                          height: 175,
                          child: lib2.Swiper(
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return TableList[index];
                            },
                            autoplay: false,
                            pagination: SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.only(bottom: 0),
                                builder: DotSwiperPaginationBuilder(
                                    color: Colors.black12)),
                          ),
                        )), //测评表格
                    Container(
                      color: Colours.bg_gray,
                      padding: EdgeInsets.only(left: 10.0, right: 10),
                      child: MyCard(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '张三',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '上午好,欢迎您进入系统!',
                                        style: TextStyle(
                                            color: Colors.black12,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.centerRight,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'http://pic.51yuansu.com/pic2/cover/00/32/66/5810fed3aa0df_610.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                height: 2,
                                color: Colors.black12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                      child: Row(
                                    children: <Widget>[
                                      Image.asset('assets/images/ranking.png',
                                          height: 14, width: 14),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '健康排名：5',
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  )),
                                  Expanded(
                                      child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/integral.png',
                                        height: 14,
                                        width: 14,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '健康积分:768',
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  )),
                                  Expanded(
                                      child: Row(
                                    children: <Widget>[
                                      Image.asset('assets/images/step_num.png',
                                          height: 14, width: 14),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '运动步数:16480',
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: MyCard(
                          child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('健康知识'),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text('更多',style: TextStyle(color: Colors.black12),),
                                      SizedBox(width: 10,),
                                      loadAssetImage('arrow.png',height: 12,width: 12),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: columnsInfoList.length,
                              itemBuilder: (context, index) =>
                                  _buildItem(index),
                            ),
                          )
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  _buildItem(int index) {
    return GestureDetector(
      child: (columnsInfoList[index].cover2 == null ||
              columnsInfoList[index].cover3 == null)
          ? getContentItem(columnsInfoList[index])
          : getThreeImagItem(columnsInfoList[index]),
      onTap: () {
        if (columnsInfoList[index].type == 'T') {
          Router.push(context, Router.topicPage, true);
        } else {
          Router.push(
              context, Router.consulationDetailPage, columnsInfoList[index]);
        }
      },
    );
  }

  getContentItem(ConsulationColumnsInfo item) {
    return Container(
        height: 120,
        color: Colors.white,
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.network(
                item.cover1,
                height: 90,
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.title),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '中国健康网',
                        style: TextStyle(color: Colors.black12, fontSize: 12),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            '${item.readCount}人查看·12小时前',
                            style:
                                TextStyle(color: Colors.black12, fontSize: 12),
                          ),
                          alignment: Alignment.bottomLeft,
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ));
  }

  getThreeImagItem(ConsulationColumnsInfo item) {
    return Container(
        height: 135,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 5.0),
        padding:
            const EdgeInsets.only(left: 10.0, right: 10.0, top: 5, bottom: 5.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 2,
              color: Colors.black12,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(item.title),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Image.network(
                    item.cover1,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    item.cover2,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    item.cover3,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            )
          ],
        ));
  }

  void requestLunBoTu() async {
    var numb = 0;
    var result = await MockRequest().get('banner', params: {'pageNume': numb});
    var resu = result['banner'];
    testList =
        resu.map<BannerModel>((item) => BannerModel.fromMap(item)).toList();
    setState(() {});
  }
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text("${++index}/$itemCount",
          style: TextStyle(color: Colors.white70, fontSize: 11.0)),
    );
  }
}

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        width: 24.0,
        height: 24.0,
        child: new CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
