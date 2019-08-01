import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart' as lib1;
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/banner_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart' as lib2;
import 'package:flutter_first/util/router.dart';

import 'package:flutter_first/pages/home/home_widgets/Table0Page.dart';
import 'package:flutter_first/pages/home/home_widgets/Table1Page.dart';
import 'package:flutter_first/mock_request.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String tu0;
  static String tu1;
  static String tu2;
  List<BannerModel> testList;

  List TableList = [
    Table0(),
    Table1(),
  ];
  @override
  void initState() {
    requestLunBoTu();
  }

  Widget buildBanner(BuildContext context, List<BannerModel> list) {
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
              Router.push(context, model.url, {'title': model.title});
            },
            child: new CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: model.imagePath,
              placeholder: (context, url) => new ProgressView(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Row(
        //扫码加搜索栏
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              height: 40,
              child: IconButton(
                icon: Image.asset('assets/images/saomiao.png'),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
              flex: 13,
              child: Container(
                  height: 40,
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(hintText: "输入搜索内容"),
                  )))
        ],
      ),
      buildBanner(context, testList), //扫码搜索栏
      Container(
        //通知栏
        height: 25,
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.asset('assets/images/喇叭.png'),
              ),
              Expanded(
                flex: 10,
                child: Text('今年心理状况采集活动开始啦!点击进入!'),
              )
            ],
          ),
          onPressed: () {
            Router.pushNoParams(context, Router.psychologicalTest);
          },
        ),
      ), //消息通知
      SizedBox(
        height: 3,
        child: Container(color: Colors.black12),
      ),
      Padding(
        //用户欢迎
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    'http://pic.51yuansu.com/pic2/cover/00/32/66/5810fed3aa0df_610.jpg',
                    fit: BoxFit.fill,
                  ),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  height: 40,
                  width: 50,
                  alignment: Alignment.topLeft,
                  child: Text('张警官'),
                )),
            Expanded(
              flex: 8,
              child: Text(
                '张警官,上午好,欢迎您进入系统~',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ), //用户欢迎
      Row(
        //健康运动步数
        children: <Widget>[
          Expanded(
              flex: 100,
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
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              '健康积分',
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              '5',
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              '健康排名',
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onPressed: () {},
              )),
          Expanded(
            flex: 1,
            child: Container(
              width: 0.01,
              height: 50,
              color: Colors.black12,
            ),
          ),
          Expanded(
              flex: 100,
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
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              '运动步数',
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              '5',
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              '运动排名',
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onPressed: () {},
              )),
        ],
      ), //健康积分
      SizedBox(
        height: 3,
        child: Container(color: Colors.black12),
      ),
      Padding(
          //测评小表格
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
            height: 165,
            child: lib2.Swiper(
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return TableList[index];
              },
              autoplay: false,
              pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 0),
                  builder: DotSwiperPaginationBuilder(color: Colors.black12)),
            ),
          )), //测评表格
      SizedBox(
        height: 3,
        child: Container(color: Colors.black12),
      ),
      Container(
        //  更多
        height: 20,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Image.asset('assets/images/xiaokuai.png'),
            ),
            Expanded(
              flex: 10,
              child: Align(
                alignment: FractionalOffset.centerRight,
                child: FlatButton(
                  child: Text(
                    '更多',
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ), //更多
      SizedBox(
        height: 2,
        child: Container(color: Colors.black12),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '2018年全局高位冠心病患者越来越多',
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    '中国健康网                       30',
                    style: TextStyle(fontSize: 13, color: Colors.black26),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
            ),
            Expanded(
              flex: 1,
              child: Image.network(
                'http://image.uczzd.cn/793049627461073302.jpg',
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 2,
        child: Container(color: Colors.black12),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '"数据警察"亮相上海!',
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    '中国警察网                       29',
                    style: TextStyle(fontSize: 13, color: Colors.black26),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
            ),
            Expanded(
              flex: 1,
              child: Image.network(
                'http://appimages.scpublic.cn/160_160/newsthumb89968.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 2,
        child: Container(color: Colors.black12),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '全国“经侦流动大讲堂”巡回教学活动湖南专场举行',
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    '中国警察网                       30',
                    style: TextStyle(fontSize: 13, color: Colors.black26),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
            ),
            Expanded(
              flex: 1,
              child: Image.network(
                'http://5b0988e595225.cdn.sohucs.com/images/20171123/c3601b8130da4898947c70647b2b94e2.jpeg',
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 2,
        child: Container(color: Colors.black12),
      ),
      Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
          height: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '脑梗患者预防复发,生活上有什么好办法吗?',
                style: TextStyle(fontSize: 17),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 80,
                      child: Image.asset(
                        'assets/images/tu1.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 80,
                      child: Image.asset(
                        'assets/images/tu0.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 80,
                      child: Image.asset(
                        'assets/images/tu2.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    ]);
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
