import 'package:flutter/material.dart';
import 'package:flutter_first/bean/psyteacherlist.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class instructor_demeanor extends StatefulWidget {
  @override
  _instructor_demeanorState createState() => _instructor_demeanorState();
}

class _instructor_demeanorState extends State<instructor_demeanor> {
  List<PsyTeacherList> Ranklist = List();
  List<PsyTeacherList> BestList = List();
  bool isShowLoadingRank = true; //\
  bool isShowLoadingBest = true; //\

  void initState() {
    super.initState();
    _requestBest();
    _requestFirstRank();
  }

  @override
  void _requestFirstRank() {
    DioUtils.instance.requestNetwork<PsyTeacherList>(
        Method.get, Api.PsyTeacherList,
        isList: true, onSuccessList: (data) {
      setState(() {
        Ranklist = data;
        isShowLoadingRank = false;
      });
    }, onError: (code, msg) {
      print("sssss");
    });
  }

  void _requestBest() {
    DioUtils.instance.requestNetwork<PsyTeacherList>(
        Method.get, Api.PsyTeacherBest,
        isList: true, onSuccessList: (data) {
      setState(() {
        BestList = data;
        isShowLoadingBest = false;
      });
    }, onError: (code, msg) {
      print("sssss");
    });
  }

  void _Rank(int index, List<PsyTeacherList> list) {
    DioUtils.instance.requestNetwork<PsyTeacherList>(
        Method.get, Api.PsyTeacherList,
        queryParameters: {"id": list[index].id},
        isList: true, onSuccessList: (data) {
      _requestFirstRank();
    }, onError: (code, msg) {
      print("sssss");
    });
  }

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '教官列表',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 32),
        ),
        backgroundColor: Colours.line,
        body: ListView(
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.all(10),
                height: ScreenUtil().setHeight(35),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(5),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '本周最美教官',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(left: 10, top: 10),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colours.line,
                      height: 1,
                    ),
                    isShowLoadingBest
                        ? LoadingWidget.childWidget()
                        : (BestList.length == 0)
                            ? Container(
                                width: double.infinity,
                                height: double.infinity,
                                alignment: Alignment.center,
                                child: Text('暂无数据'),
                              )
                            : Container(
                                //height: double.infinity,
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        BestList[0].imgId),
                                                    fit: BoxFit.fill),
                                                borderRadius:
                                                    BorderRadius.circular(35))),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(BestList[0].name),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              BestList[0].orgId,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              BestList[0].shortDesc,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('格言:   '),
                                        Text(
                                          BestList[0].slogan,
                                          style: TextStyle(color: Colors.grey),
                                        )
                                        //Text( BestList[0].slogan)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('特长:   '),
                                        Expanded(
                                          child: Text(
                                            BestList[0].major,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        )
                                        //Text( BestList[0].slogan)
                                      ],
                                    ),
                                  ],
                                )),
                  ],
                ),
              ),
              onTap: (){
                Router.push(context, Router.instructor_demeanor_detailPage,BestList[0]);//记得改List
                },
            ),
            Container(
                margin: EdgeInsets.all(10),
                height: ScreenUtil().setHeight(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '本单位教官',
                            style: TextStyle(fontSize: 17),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '更多  ',
                                  style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(left: 10, top: 10),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colours.line,
                      height: 1,
                    ),
                    isShowLoadingRank
                        ? LoadingWidget.childWidget()
                        : (Ranklist.length == 0)
                        ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: Text('暂无数据'),
                    )
                        : Container(
                      //height: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                Ranklist[0].imgId),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                        BorderRadius.circular(35))),
                                onTap: (){
                                  Router.push(context, Router.instructor_demeanor_detailPage,Ranklist[0]);
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(Ranklist[0].name)
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                Ranklist[1].imgId),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                        BorderRadius.circular(35))),
                                onTap: (){
                                  Router.push(context, Router.instructor_demeanor_detailPage,Ranklist[1]);
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(Ranklist[1].name)
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                Ranklist[2].imgId),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                        BorderRadius.circular(35))),
                                onTap: (){
                                  Router.push(context, Router.instructor_demeanor_detailPage,Ranklist[2]);
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(Ranklist[2].name)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),



            SizedBox(
              height: 5,
            ),
            isShowLoadingRank
                ? LoadingWidget.childWidget()
                : (Ranklist.length == 0)
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text('暂无数据'),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 1.4),
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          Widget itemWidget;
                          String num;

                          if (index < 9) {
                            num = "0" + "${index + 1}";
                          } else {
                            num = "${index + 1}";
                          }
                          if (index == 0) {
                            itemWidget = Container(
                              child: loadAssetImage('mine/rank/排行 1.png',
                                  height: 25),
                              //padding: EdgeInsets.fromLTRB(10,10,10,10),
                            );
                          } else if (index == 1) {
                            itemWidget = Container(
                              child: loadAssetImage('mine/rank/排行 2.png',
                                  height: 25),
                              //padding: EdgeInsets.fromLTRB(10,10,10,10),
                            );
                          } else if (index == 2) {
                            itemWidget = Container(
                              child: loadAssetImage('mine/rank/排行 3.png',
                                  height: 25),
                              //padding: EdgeInsets.fromLTRB(10,10,10,10),
                            );
                          } else {
                            itemWidget = Container(
                              height: 25,
                              child: CircleAvatar(
                                backgroundColor: Colors.black12,
                                radius: 10,
                                child: Text(
                                  num,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ),
                            );
                          }
                          return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      itemWidget,
                                      //Image.asset('assets/images/mine/rank/排行 1.png',height: 25,width: 25,)
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              height: 38,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          Ranklist[index].imgId),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                  BorderRadius.circular(35))),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(Ranklist[index].name),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              GestureDetector(
                                                child: Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'assets/images/consultation/点赞.png',
                                                      height: 13,
                                                      width: 13,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '${Ranklist[index].likeCount}',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                                  ],
                                                ),
                                                onTap: () {
                                                  _Rank(index, Ranklist);
                                                },
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        Ranklist[index].orgId,
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        Ranklist[index].shortDesc,
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: (){
                              Router.push(context, Router.instructor_demeanor_detailPage,Ranklist[index]);
                            },
                          );
                        })
          ],
        ));
  }
}
