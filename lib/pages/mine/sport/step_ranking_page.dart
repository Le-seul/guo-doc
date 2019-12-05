import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/step_ranking.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/mock_request.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepRanking extends StatefulWidget {
  @override
  _StepRankingState createState() => _StepRankingState();
}

class _StepRankingState extends State<StepRanking> implements RefreshList{
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
      backgroundColor: Colours.line,
      appBar: AppBar(
        title: Text(
          '步数排行',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black, size: 32),
        actions: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/mine/rank/fenxiang.png',
              height: 10,
            ),
            padding: EdgeInsets.all(15),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(4),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: ListView.custom(
                physics: ClampingScrollPhysics(),
                childrenDelegate: MySliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _buildItem(index);
                  },
                  childCount: 30,
                ),
                cacheExtent: 0.0,
              )),
          Positioned(
              bottom: 0.0,
              child:  Offstage(
                offstage: offstage,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          backgroundColor: Colors.black12,
                          radius: 13,
                          child: Container(
                            child: Text(
                              '9',
                              style: TextStyle(fontSize: 17, color: Colors.black54),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(5),
                        child: ClipOval(
                          child: Image.network(
                              'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2080823830,3911438045&fm=26&gp=0.jpg'),
                        ),
                      ),
                      Expanded(child: Text('  张警官')),
                      loadAssetImage('mine/脚印.png', height: 20),
                      Text(
                        '  20000',
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        width: 15,
                      ),

                    ],
                  ),
                ),
              ),
          )
        ],
      ),
    );
  }

  @override
  void refresh(bool visiblity) {
    setState(() {
      offstage = visiblity;
    });
  }
}

_buildItem(int index) {
  Widget itemWidget;
  String num;

  if (index < 9) {
    num = "0" + "${index + 1}";
  } else {
    num = "${index + 1}";
  }
  if (index == 0) {
    itemWidget = Container(
      height: 50,
      width: 50,
      child: loadAssetImage('mine/rank/排行 1.png', height: 40),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    );
  } else if (index == 1) {
    itemWidget = Container(
      height: 50,
      width: 50,
      child: loadAssetImage('mine/rank/排行 2.png', height: 40),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    );
  } else if (index == 2) {
    itemWidget = Container(
      height: 50,
      width: 50,
      child: loadAssetImage('mine/rank/排行 3.png', height: 40),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    );
  } else {
    itemWidget = Container(
      padding: EdgeInsets.all(10),
      height: 50,
      width: 50,
      child: CircleAvatar(
        backgroundColor: Colors.black12,
        radius: 13,
        child: Container(
          child: Text(
            num,
            style: TextStyle(fontSize: 17, color: Colors.black54),
          ),
        ),
      ),
    );
  }
  return GestureDetector(
    onTap: () {},
    child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              itemWidget,
              Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(5),
                child: ClipOval(
                  child: Image.network(
                      'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2080823830,3911438045&fm=26&gp=0.jpg'),
                ),
              ),
              Expanded(child: Text('  张警官')),
              loadAssetImage('mine/脚印.png', height: 20),
              Text(
                '  20000',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          height: 1,
          color: Colours.line,
        ),
      ],
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

  addSequenceToList(List<int> list, int sequenceStart, int sequenceEnd) {
    if (sequenceStart <= sequenceEnd) {
      for (var i = sequenceStart; i <= sequenceEnd; i++) {
        list.add(i);
      }
    } else {
      for (var i = sequenceEnd; i >= sequenceStart; i--) {
        list.add(i);
      }
    }
  }

  update(VisibilityState newState) {
    if (lastState != null &&
        newState.firstIndex == lastState.firstIndex &&
        newState.lastIndex == lastState.lastIndex) {
      return;
    }

    final changeSet = ChangeSet();

    if (lastState == null) {
      addSequenceToList(
          changeSet.exposure, newState.firstIndex, newState.lastIndex);
    } else if (newState.firstIndex > lastState.lastIndex) {
      addSequenceToList(
          changeSet.exposure, newState.firstIndex, newState.lastIndex);
      addSequenceToList(
          changeSet.hidden, lastState.firstIndex, lastState.lastIndex);
    } else if (newState.lastIndex < lastState.firstIndex) {
      addSequenceToList(
          changeSet.exposure, newState.lastIndex, newState.firstIndex);
      addSequenceToList(
          changeSet.hidden, lastState.lastIndex, lastState.firstIndex);
    } else {
      if (newState.firstIndex < lastState.firstIndex) {
        addSequenceToList(
            changeSet.exposure, lastState.firstIndex - 1, newState.firstIndex);
      }

      if (newState.firstIndex > lastState.firstIndex) {
        addSequenceToList(
            changeSet.hidden, lastState.firstIndex, newState.firstIndex - 1);
      }

      if (newState.lastIndex > lastState.lastIndex) {
        addSequenceToList(
            changeSet.exposure, lastState.lastIndex + 1, newState.lastIndex);
      }

      if (newState.lastIndex < lastState.lastIndex) {
        addSequenceToList(
            changeSet.hidden, lastState.lastIndex, newState.lastIndex + 1);
      }
    }

    lastState = newState;

    if (!changeSet.empty) {
      changeSet.exposure.forEach((i) {
        if(i == 15){
          eventBus.fire(Refresh(true));
        }
        print('第 $i 张卡片曝光了');
      });

       changeSet.hidden.forEach((i) {
         if(i == 15){
           eventBus.fire(Refresh(false));
         }
        print('第 $i 张卡片隐藏了');
      });
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
abstract class RefreshList {
  void refresh(bool offstage);
}