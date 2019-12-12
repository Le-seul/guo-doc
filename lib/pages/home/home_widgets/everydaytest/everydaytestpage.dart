import 'package:flutter/material.dart';
import 'package:flutter_first/bean/daytest_like.dart';
import 'package:flutter_first/bean/psydailytest.dart';
import 'package:flutter_first/bean/coreading.dart';
import 'package:flutter_first/mock_request.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/first.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/widgets/loading_widget.dart';

class EverydayTest extends StatefulWidget {
  @override
  _EverydayTestState createState() => _EverydayTestState();
}

class _EverydayTestState extends State<EverydayTest>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    //生命周期函数,固定写法
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('趣味自测'),
        centerTitle: true,
        backgroundColor: Colours.bg_green,
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Text('每日一测',style: TextStyle(fontSize: 16),),
            ),
            Tab(
              child: Text('已测结果',style: TextStyle(fontSize: 16),),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          All(),
          Selected(),
        ],
      ),
    );
  }
}

class All extends StatefulWidget {
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  List<PsyDailyTest> psylist = List();
  List<PsyDailyTest> Alllist = List();
  bool isShowLoading = true;

  @override
  void initState() {
    //生命周期函数,固定写法
    _requestData();

  }
  _getTestLike(String id ) {
    DioUtils.instance
        .requestNetwork<TestLike>(Method.get,
        Api.PsyDailyTestedLike,
        queryParameters: {
          'id': id.toString(),
        },
        isList: true, onSuccessList: (data) {
          setState(() {

          });
        }, onError: (code, msg) {
          setState(() {
          });
        });
  }

  void _requestData() {
    DioUtils.instance.requestNetwork<PsyDailyTest>(Method.get, Api.PsyDailyTest,
        isList: true, onSuccessList: (data) {
      setState(() {
        psylist = data;
        isShowLoading = false;
        print(psylist);
//        for (PsyDailyTest item in psylist) {
//          if (item.state == 1) {
//            Alllist.add(item);
//            //Alllist.sort();
//            continue;
//          }
 //       }
      });
    }, onError: (code, msg) {
      print("sssss");
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : (psylist.length == 0)
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text('暂无数据'),
                )
              : ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: psylist.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                          //  _getTestLike(psylist[index].questionId);
                            NavigatorUtil.pushPage(context,Test0(questionnaireId: psylist[index].questionId,));
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  height: 180,
                                  child: Image.network(
                                    psylist[index].coverImgId,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[Text(
                                      psylist[index].title,
                                      style: TextStyle(fontSize: 19),
                                    ),],
                                  )

                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  child: Text(
                                    psylist[index].description,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black45),
                                  ),
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),

                                ),
                                SizedBox(
                                  height: 21,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 10,
                          color: Colours.line,
                        ),
                      ],
                    );
                  },
                ),
    );
  }
}

class Selected extends StatefulWidget {
  @override
  _SelectedState createState() => _SelectedState();
}

class _SelectedState extends State<Selected> {
  List<PsyDailyTest> psylist = List();
  List<PsyDailyTest> Selectedlist = List();
  bool isShowLoading = true;
  void initState() {
    //生命周期函数,固定写法
    _requestData();

  }


  void _requestData() {
    DioUtils.instance.requestNetwork<PsyDailyTest>(Method.get, Api.PsyDailyTested,
        isList: true, onSuccessList: (data) {
          setState(() {
            Selectedlist = data;
            isShowLoading = false;
//            for (PsyDailyTest item in psylist) {
//              if (item.state == 1) {
//                Selectedlist.add(item);
//                //Alllist.sort();
//                continue;
//              }
//            }
          });
        }, onError: (code, msg) {
          isShowLoading = false;
          print("sssss");
        });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:  (Selectedlist.length == 0)
          ? Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text('暂无数据'),
      )
          : ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: Selectedlist.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  NavigatorUtil.pushPage(context,Test0(questionnaireId: Selectedlist[index].questionId,));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                        height: 180,
                        child: Image.network(
                          Selectedlist[index].coverImgId,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[Text(
                              Selectedlist[index].title,
                              style: TextStyle(fontSize: 19),
                            ),],
                          )

                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Container(
                        child: Text(
                          Selectedlist[index].description,
                          style: TextStyle(
                              fontSize: 12, color: Colors.black45),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 5),

                      ),
                      SizedBox(
                        height: 21,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 10,
                color: Colours.line,
              ),
            ],
          );
        },
      ),
    );;
  }
}
