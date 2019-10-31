import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flukit/flukit.dart' as lib1;

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/banner.dart';
import 'package:flutter_first/bean/psycourse.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/top_panel.dart';

class PsyCourse extends StatefulWidget {
  @override
  _PsyCourseState createState() => _PsyCourseState();
}

class _PsyCourseState extends State<PsyCourse> {
  // List<BannerImage> bannerlist;
  bool isShowLoading = true;
  List<Psycourse> psycourselist = List();
  List<Psycourse> mycourselist = List(); //我的课程
  List<Psycourse> emotionlist = List(); //情绪调节
  List<Psycourse> Dearlist = List(); //亲密关系

  @override
  void initState() {
    //_requestBanner();
    _requestPsycourse1();
  }
//  void _requestBanner() {
//    DioUtils.instance.requestNetwork<BannerImage>(Method.get, Api.BANNER,
//        isList: true, onSuccessList: (data) {
//          setState(() {
//            bannerlist = data;
//          });
//        }, onError: (code, msg) {
//          print("sssss");
//        });
//  }

  void _requestPsycourse1() {
    DioUtils.instance.requestNetwork<Psycourse>(Method.get, Api.PSYCOURSE,
        isList: true, onSuccessList: (data) {
      setState(() {
        psycourselist = data;
        isShowLoading = false;
        for (Psycourse index in psycourselist) {
          if (index.categoryId == "情绪调节") {
            emotionlist.add(index);
          }
          if (index.categoryId == "亲密关系") {
            Dearlist.add(index);
          }
          if (index.categoryId == "轮播图") {
            mycourselist.add(index);
          }
        }
      });
    }, onError: (code, msg) {
      print("sssss");
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('心理课程'),
        centerTitle: true,
        backgroundColor: Colours.bg_green,
        elevation: 0.0,
      ),
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : (psycourselist.length == 0)
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text('暂无数据'),
                )
              : ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        LoginTopPanel(),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 190,
                                child: buildBanner(context, mycourselist),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '情绪调节',
                            style: TextStyle(fontSize: 17.5),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 1.4),
                              itemCount: emotionlist.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      emotionlist[index]
                                                          .coverImgId),
                                                  fit: BoxFit.fill)),
                                          height: 90,
                                        ),
                                        onTap: (){},
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(emotionlist[index].name),
                                          Text(
                                            '共${emotionlist[index].courseCount}讲',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '亲密关系',
                            style: TextStyle(fontSize: 17.5),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 1.4),
                              itemCount: Dearlist.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      Dearlist[index]
                                                          .coverImgId),
                                                  fit: BoxFit.fill)),
                                          height: 90,
                                        ),
                                        onTap: () {
                                          Router.pushNoParams(context,
                                              Router.curriculumcatalog1);
                                        },
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(Dearlist[index].name),
                                          Text(
                                            '共${Dearlist[index].courseCount}讲',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}

Widget buildBanner(BuildContext context, List<Psycourse> list) {
  if (list == null) {
    return new Container(height: 0.0);
  }
  return new AspectRatio(
    aspectRatio: 16.0 / 9.0,
    child: lib1.Swiper(
      indicatorAlignment: AlignmentDirectional(0.95, 0.9),
      circular: true,
      interval: const Duration(seconds: 3),
      indicator: NumberSwiperIndicator(),
      children: list.map((model) {
        return new InkWell(
          onTap: () {
            Router.push(context, model.coverImgId, {'title': model.name});
          },
          child: new CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: model.coverImgId,
            placeholder: (context, url) => new ProgressView(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        );
      }).toList(),
    ),
  );
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
