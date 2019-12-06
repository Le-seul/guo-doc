import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/step_ranking.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepRanking extends StatefulWidget {
  @override
  _StepRankingState createState() => _StepRankingState();
}

class _StepRankingState extends State<StepRanking> {
  List<Stepranking> steplist = List();
  List<Stepranking> Rankinglist = List();
  bool offstage = false;
  StreamSubscription exitLogin;

  void initState() {
    exitLogin = eventBus.on<Refresh>().listen((event) {
      setState(() {
        offstage = event.offstage;
      });
    });
  }

  @override
  void dispose() {
    exitLogin.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '步数排行',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff2CA687),
        iconTheme: IconThemeData(color: Colors.white, size: 32),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Image.asset(
              'assets/images/mine/rank/fenxiang.png',
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0xff2CA687),
            height: 220,
          ),
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 45,
                        ),
                        loadAssetImage('mine/rank/second.png', height: 20),
                        CircleAvatar(
                          radius: 38.0,
                          backgroundColor: Color(0xff52aa9b),
                          child: CircleAvatar(
                            radius: 35.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'http://5b0988e595225.cdn.sohucs.com/images/20171114/0fc43e9ad58f4a5cb41a018925b0e475.jpeg'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '王警官',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8))),
                              margin: EdgeInsets.only(top: 10),
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 2, bottom: 2, left: 12, right: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    '第2名',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '18350',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.orangeAccent),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '步数',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black26),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: <Widget>[
                        loadAssetImage('mine/rank/first.png', height: 20),
                        CircleAvatar(
                          radius: 48.0,
                          backgroundColor: Color(0xff52aa9b),
                          child: CircleAvatar(
                            radius: 45.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 40.0,
                              backgroundImage: NetworkImage(
                                  'http://b-ssl.duitang.com/uploads/item/201804/21/20180421134937_creUP.thumb.700_0.jpeg'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '张警官',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8))),
                                margin: EdgeInsets.only(top: 10),
                                height: 80,
                                width: MediaQuery.of(context).size.width * 0.4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 2, bottom: 2, left: 12, right: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    '第1名',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '25350',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.orangeAccent),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '步数',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black26),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 45,
                        ),
                        loadAssetImage('mine/rank/third.png', height: 20),
                        CircleAvatar(
                          radius: 38.0,
                          backgroundColor: Color(0xff52aa9b),
                          child: CircleAvatar(
                            radius: 35.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'http://b-ssl.duitang.com/uploads/item/201809/03/20180903221703_NChzn.thumb.700_0.jpeg'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '李警官',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8))),
                                margin: EdgeInsets.only(top: 10),
                                height: 70,
                                width: MediaQuery.of(context).size.width * 0.3),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 2, bottom: 2, left: 12, right: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    '第3名',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '14350',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.orangeAccent),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '步数',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black26),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Expanded(
                child: ListView.custom(
                  physics: ClampingScrollPhysics(),
                  childrenDelegate: MySliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _buildItem(index);
                    },
                    childCount: 30,
                  ),
                  cacheExtent: 0.0,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0.0,
            child: Offstage(
              offstage: offstage,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
                width: MediaQuery.of(context).size.width - 20,
                child: itemWidget(12),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget itemWidget(int index) {
  return Row(
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        height: 50,
        width: 50,
        child: CircleAvatar(
          backgroundColor: index == 12?Colors.blue[200]:Colors.black12,
          radius: 13,
          child: Container(
            child: Text(
              '$index',
              style: TextStyle(fontSize: 17, color: index == 12?Colors.blue:Colors.black54),
            ),
          ),
        ),
      ),
      CircleAvatar(
        radius: 22.0,
        backgroundImage: NetworkImage(
            'https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3738905344,1107853336&fm=26&gp=0.jpg'),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
          child: Text(
        '张警官',
        style: TextStyle(color: index == 12?Colors.black26:Colors.black),
      )),
      Text(
        '9750',
        style: TextStyle(fontSize: 20, color: index == 12?Colors.blue:Colors.orangeAccent),
      ),
      SizedBox(
        width: 10,
      ),
    ],
  );
}

_buildItem(int index) {
  return Container(
    padding: EdgeInsets.only(top: 5, left: 10, right: 10),
    child: MyCard(
      shadowColor: Colors.transparent,
      color: index == 11 ? Colors.blue[100] : Colors.white,
      child: Container(
        padding: EdgeInsets.all(8),
        child:  itemWidget(index+1),
      ),
    ),
  );
}

class VisibilityState {
  const VisibilityState({this.firstIndex, this.lastIndex});
  final int firstIndex;
  final int lastIndex;
}

class ChangeSet {
  final List<int> exposure = [];
  final List<int> hidden = [];
  bool get empty => exposure.length == 0 && hidden.length == 0;
}

class VisibilityMonitor {
  VisibilityState lastState;
  update(VisibilityState newState) {
    if (lastState != null &&
        newState.firstIndex == lastState.firstIndex &&
        newState.lastIndex == lastState.lastIndex) {
      return;
    }
    lastState = newState;
    if (12 == lastState.lastIndex || 12 < lastState.lastIndex) {
      eventBus.fire(Refresh(true));
    } else {
      eventBus.fire(Refresh(false));
    }
  }
}

class MySliverChildBuilderDelegate extends SliverChildBuilderDelegate {
  MySliverChildBuilderDelegate(
    Widget Function(BuildContext, int) builder, {
    int childCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
  }) : super(builder,
            childCount: childCount,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries);

  final visibilityMonitor = VisibilityMonitor();

  @override
  void didFinishLayout(int firstIndex, int lastIndex) {
    visibilityMonitor.update(VisibilityState(
      firstIndex: firstIndex,
      lastIndex: lastIndex,
    ));
  }
}
