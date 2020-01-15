import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart' as lib1;
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/User.dart';
import 'package:flutter_first/bean/announcement.dart';
import 'package:flutter_first/bean/banner.dart';
import 'package:flutter_first/bean/banner_model.dart';
import 'package:flutter_first/bean/chunyu_message.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/bloc/bloc_provider.dart';
import 'package:flutter_first/bloc/chunyu_bloc.dart';
import 'package:flutter_first/bean/step_ranking.dart' as step;
import 'package:flutter_first/bloc/step_count.bloc.dart';
import 'package:flutter_first/mock_request.dart';
import 'package:flutter_first/net/common_dio.dart';
import 'package:flutter_first/pages/consultation/consultation_detail_page.dart';
import 'package:flutter_first/pages/consultation/topic_page.dart';
import 'package:flutter_first/pages/home/home_widgets/Table0_Page.dart';
import 'package:flutter_first/pages/mine/sport/step_ranking_page.dart';
import 'package:flutter_first/pages/search_page.dart';
import 'package:flutter_first/pages/service/servicenext/activity.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_first/util/dialog.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/search.dart';
import 'package:flutter_first/widgets/top_panel.dart';
import 'package:flutter_swiper/flutter_swiper.dart' as lib2;

import '../../net/api.dart';
import '../../net/dio_utils.dart';

class HomePage extends StatefulWidget {
  VoidCallback onPress;
  HomePage(this.onPress);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String defaultImage =
      'https://www.aireading.club/phms_resource_base/image_base/BJ_YaJianKang_02.jpg';
  List<BannerImage> bannerlist;
  var listText = ['今年心理健康状况采集活动开始啦！', '心理健康资讯有新的内容啦！', '参与填写心理健康问卷可获取最新的健康报告！'];
  List<Announcement> listAnnouncement = List();
  int stepRanking = 1;
  ChunyuMessage chunyuMessage = new ChunyuMessage();
  List<ConsulationColumnsInfo> columnsInfoList = List();
  List<UserInfor> UserList = List();
  String createTime;
  bool isShowLoading = true;
  String time;

  @override
  void initState() {
    _requestBanner();
    _getColumnsInfo();
    _getStepRanking();
    _getUser();
    _getAnnouncement();
    int currenttime = DateTime.now().hour;
    print('当下时间：$currenttime');
    if(currenttime>=5 && currenttime<=12){
      time = '上午好';
    }else if(currenttime>=13 && currenttime<=18){
      time = '下午好';
    }else{
      time = '晚上好';
    }

  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();

      Map<String, dynamic> _map = json.decode(barcode);
      String model = _map["model"];
      String target = _map["target"];
      print('model: $model' + 'target: $target');

      if (model == "activity") {
        Future.delayed(Duration(milliseconds: 1)).then((value) {
          ShowIsSignDialog.showMyMaterialDialog(context, target);
        });
      }
    } catch (e) {
      // 扫码错误
      print('扫码错误: $e');
    }
  }

  _getAnnouncement() {
    DioUtils.instance.requestNetwork<Announcement>(
        Method.get, Api.GETANNOUNCEMENT,
        isList: true, onSuccessList: (data) {
      setState(() {
        listAnnouncement = data;
        print('获取通告成功！');
      });
    }, onError: (code, msg) {
      print('获取通告失败！');
    }, noExistError: () {
      print('请求的对象不存在或已被删除！');
    });
  }

  _getStepRanking() {
    DioUtils.instance.requestNetwork<step.StepRanking>(
        Method.get, Api.GRTSTEPRANKING, onSuccess: (data) {
      setState(() {
        stepRanking = data.stepRanking;
        print('获取排名成功！');
      });
    }, onError: (code, msg) {
      print('获取排名失败！');
    }, noExistError: () {
      print('请求的对象不存在或已被删除！');
    });
  }

  void _getUser() {
    DioUtils.instance.requestNetwork<UserInfor>(
      Method.get,
      Api.USERINFOR,
      queryParameters: {
        "id": '1',
      },
      isList: true,
      onSuccessList: (data) {
        setState(() {
          UserList.addAll(data);
          isShowLoading = false;
        });
      },
      onError: (code, msg) {
        setState(() {
          Toast.show('请求失败');
        });
      },
    );
  }

  void _getColumnsInfo() {
    DioUtils.instance.requestNetwork<ConsulationColumnsInfo>(
      Method.get,
      Api.GETDEFAUTLTCOLUMNINFO,
      queryParameters: {"columnId": 1, "pageSize": 10, "pageNumber": 1},
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
      aspectRatio: 2.0 / 1.0,
      child: lib1.Swiper(
        indicatorAlignment: AlignmentDirectional.topEnd,
        circular: true,
        interval: const Duration(seconds: 5),
        indicator: NumberSwiperIndicator(),
        children: list.map((model) {
          return new InkWell(
            onTap: () {
              model.state == 0
                  ? NavigatorUtil.pushWebView(
                      context, model.actionTarget, {'title': model.name})
                  : null;
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
    final StepCountBloc bloc = BlocProvider.of<StepCountBloc>(context);
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            LoginTopPanel(),
            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQueryData.fromWindow(window).padding.top + 15,
                ),
                Row(
                  //扫码加搜索栏
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: SearchTextFieldWidget(
                          isborder: false,
                          controller: TextEditingController(),
                          hintText: '请输入搜索内容',
                          margin:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          onTab: () {
                            NavigatorUtil.pushPage(
                                context, SesrchPage('*', '请输入搜索内容'));
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        scan();
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 10),
                        height: 25,
                        child: loadAssetImage('scanning.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
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
            )
          ],
        ),
        Container(
          color: Colours.bg_gray,
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                    //通知栏
                    padding: EdgeInsets.only(right: 8, left: 15, top: 5),
                    height: 25,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            '公告',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xff2CA687),
                              borderRadius: BorderRadius.circular(2.0)),
                          padding: EdgeInsets.only(
                              top: 2, bottom: 2, right: 5, left: 5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        listAnnouncement.isEmpty
                            ? Container()
                            : Expanded(
                                child: lib2.Swiper(
                                  autoplay: true,
                                  autoplayDelay: 3000,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listAnnouncement.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        listAnnouncement[index].content,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        Align(
                          child: loadAssetImage('arrow.png',
                              height: 12, width: 12),
                          alignment: Alignment.centerRight,
                        )
                      ],
                    )),
                onTap: () {
                  NavigatorUtil.pushWebView(
                      context,
                      'http://ygyd.aireading.top/ygyd/create?taskId=aaa&userId=1&scaleCode=10012&sex=0&age=1',
                      {'title': '专业测评'});
                },
              ),
              //消息通知
              Padding(
                  //测评小表格
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Container(
                    height: 175,
                    child: Table0(),
//                          lib2.Swiper(
//                            itemCount: 1,
//                            itemBuilder: (BuildContext context, int index) {
//                              return TableList[index];
//                            },
//                            autoplay: false,
//                            pagination: SwiperPagination(
//                                alignment: Alignment.bottomCenter,
//                                margin: EdgeInsets.only(bottom: 0),
//                                builder: DotSwiperPaginationBuilder(
//                                    color: Colors.black12)),
//                          ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  UserList.isNotEmpty
                                      ? UserList[0].userName
                                      : '张警官',
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '$time,欢迎您进入系统!',
                                  style: TextStyle(
                                      color: Colors.black12, fontSize: 12),
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
                                  UserList.isNotEmpty
                                      ? UserList[0].imageId
                                      : 'https://www.aireading.club/phms_resource_base/image_base/%E6%95%99%E5%AE%98%E7%85%A7%E7%89%87/%E7%8E%8B%E5%BB%BA%E6%9D%B0-%E4%B8%B0%E5%8F%B0/%E7%8E%8B%E5%BB%BA%E6%9D%B0-%E4%B8%B0%E5%8F%B01.jpg',
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                NavigatorUtil.pushPage(context, StepRanking());
                              },
                              child: Row(
                                children: <Widget>[
                                  Image.asset('assets/images/ranking.png',
                                      height: 14, width: 14),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '步数排名：$stepRanking',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Image.asset('assets/images/step_num.png',
                                      height: 14, width: 14),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  StreamBuilder<int>(
                                    stream: bloc.stream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<int> snapshot) {
                                      return Text(
                                        '运动步数：${snapshot.data ?? 0}',
                                        style: TextStyle(fontSize: 12),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10.0),
                child: MyCard(
                    child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            '健康知识',
                            style: TextStyle(fontSize: 15),
                          )),
                          GestureDetector(
                            onTap: () {
                              widget.onPress();
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '更多',
                                  style: TextStyle(color: Colors.black12),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                loadAssetImage('arrow.png',
                                    height: 12, width: 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0.0),
                        itemCount: columnsInfoList.length,
                        itemBuilder: (context, index) => _buildItem(index)),
                  ],
                )),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  _buildItem(int index) {
    //将时间字符串转为时间对象
    DateTime moonLanding = DateTime.parse(columnsInfoList[index].createTime);
    int second = (DateTime.now().millisecondsSinceEpoch-moonLanding.millisecondsSinceEpoch)~/1000;
    if(second <= 3*60){
      createTime = '刚刚';
    }else if(second<= 60*60){
      createTime = '${DateTime.now().minute-moonLanding.minute}分钟前';
    }else if(second<= 24*60*60){
      createTime = '${DateTime.now().hour-moonLanding.hour}小时前';
    }else if(second<= 30*24*60*60){
      createTime = '${DateTime.now().day-moonLanding.day}天前';
    }else {
      createTime = '${columnsInfoList[index].createTime.substring(0,11)}';
    }

    return GestureDetector(
      child: (columnsInfoList[index].cover2 == null ||
              columnsInfoList[index].cover3 == null)
          ? getContentItem(columnsInfoList[index], index)
          : getThreeImagItem(columnsInfoList[index]),
      onTap: () {
        if (columnsInfoList[index].type == 'T') {
          NavigatorUtil.pushPage(context, TopicPage(columnsInfoList[index].id));
          CommonRequest.UserReadingLog(
              columnsInfoList[index].id, columnsInfoList[index].type, 'DJ');
        } else {
          NavigatorUtil.pushPage(
              context,
              ConsultationDetailPage(
                id: columnsInfoList[index].id,
                imgurl: columnsInfoList[index].cover1,
              ));
          CommonRequest.UserReadingLog(
              columnsInfoList[index].id, columnsInfoList[index].type, 'YD');
        }
      },
    );
  }

  getContentItem(ConsulationColumnsInfo item, int index) {
    return Column(
      children: <Widget>[
        Container(
            height: 90,
            color: Colors.white,
            padding: EdgeInsets.only(
                left: 5.0, right: 10.0, bottom: 10.0, top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              item.title,
                              style: TextStyle(fontSize: 15),
                              strutStyle: StrutStyle(height: 1.5),
                            ),
                          ),
                          Container(
                              child: Row(
                            children: <Widget>[
                              Text(
                                '中国健康网',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 11),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                createTime??'',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 11),
                              ),
                            ],
                          )),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Image.network(
                    item.cover1 ?? defaultImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            )),
        Container(
          color: Colours.line,
          height: 1,
          margin: EdgeInsets.only(left: 10, right: 10),
        )
      ],
    );
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
                    item.cover1 ?? defaultImage,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    item.cover2 ?? defaultImage,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    item.cover3 ?? defaultImage,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            )
          ],
        ));
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
