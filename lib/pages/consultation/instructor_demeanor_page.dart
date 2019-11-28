import 'package:flutter/material.dart';
import 'package:flutter_first/bean/psyteacherlist.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/instructor_demeanor_detail_page.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/util/number.dart';

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
        print('教官成功');
        Ranklist = data;
        isShowLoadingRank = false;
      });
    }, onError: (code, msg) {
      print('教官失败');
    });
  }

  void _requestBest() {
    DioUtils.instance.requestNetwork<PsyTeacherList>(
        Method.get, Api.PsyTeacherBest,
        isList: true, onSuccessList: (data) {
      setState(() {
        BestList = data;
        isShowLoadingBest = false;
        print('教官列表成功');
      });
    }, onError: (code, msg) {
      print('教官列表失败');
    });
  }

  void _Rank(int index, List<PsyTeacherList> list) {
    DioUtils.instance.requestNetwork<PsyTeacherList>(
        Method.get, Api.PsyTeacherList,
        queryParameters: {"id": list[index].id},
        isList: true,
        onSuccessList: (data) {
      _requestFirstRank();
    },
        onError: (code, msg) {
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
                margin: EdgeInsets.only(top: 20,bottom: 0),
                height: ScreenUtil().setHeight(35),
                  color: Colors.white,
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
                                            Row(
                                              children: <Widget>[
                                                Text(BestList[0].name,
                                                style: TextStyle(
                                                  fontSize: 18
                                                ),),
                                                SizedBox(width: 5,),
                                                Text(
                                                  BestList[0].orgId,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),

                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              BestList[0].pqc,
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
                                        Container(
                                          width: 80,
                                        ),
                                        Text('格言:   '),
                                        Text(
                                          BestList[0].slogan,
                                          style: TextStyle(color: Colors.grey),
                                        )
                                        //Text( BestList[0].slogan)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 80,
                                        ),
                                        Expanded(
                                          child: RichText(
                                              text: TextSpan(
                                                text: '特长:   ',
                                                style: TextStyle(color: Colors.black),
                                                children:<TextSpan>[
                                                  TextSpan(
                                                    text: BestList[0].major,
                                            style:
                                                TextStyle(color: Colors.grey),
                                                  )
                                                ]
                                              ))
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                  ],
                ),
              ),
              onTap: (){
                NavigatorUtil.pushPage(context,instructor_demeanor_detail(id:BestList[0].id));
                },
            ),
            Container(
              margin: EdgeInsets.only(top: 16,bottom: 0),
                height: 198,
              color: Colors.white,
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
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                Ranklist[0].imgId),
                                            ),
                                        borderRadius:
                                        BorderRadius.circular(35))),
                                onTap: (){
                                  NavigatorUtil.pushPage(context,instructor_demeanor_detail(id:Ranklist[0].id));
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
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                Ranklist[1].imgId),
                                            ),
                                        borderRadius:
                                        BorderRadius.circular(35))),
                                onTap: (){
                                  NavigatorUtil.pushPage(context,instructor_demeanor_detail(id:Ranklist[1].id));
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
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                Ranklist[2].imgId),
                                            ),
                                        borderRadius:
                                        BorderRadius.circular(35))),
                                onTap: (){
                                  NavigatorUtil.pushPage(context,instructor_demeanor_detail(id:Ranklist[2].id));
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
              height: 16,
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
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 1,
                            childAspectRatio: 1.6),
                        itemCount: Ranklist.length,
                        itemBuilder: (context, index) {

                          return GestureDetector(
                            child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              height: 42,
                                              width: 42,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          Ranklist[index].imgId),
                                                      ),
                                                  borderRadius:
                                                  BorderRadius.circular(21))),
                                          SizedBox(height: 20,)
                                        ],
                                      ),
                                      SizedBox(
                                        width: 7  ,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Flex(
                                              direction: Axis.horizontal,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[

                                                Text(Ranklist[index].name,style:TextStyle(fontSize: 18) ,),
                                                SizedBox(
                                                  width: 7  ,
                                                ),
                                                 Expanded(
                                                   child: Text(
                                                    Ranklist[index].orgId,
                                                    style: TextStyle(
                                                        fontSize: 12, color: Colors.grey.shade600),
                                                    overflow: TextOverflow.ellipsis,
                                                ),
                                                 ),

                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              Ranklist[index].pqc,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12, color: Colors.grey.shade600),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              child: Row(
                                                children: <Widget>[
                                                  Image.asset(
                                                    'assets/images/consultation/点赞.png',
                                                    height: 16,
                                                    width: 16,
                                                    color: Colors.green.shade200,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    Number(Ranklist[index].likeCount),
                                                    style: TextStyle(
                                                        color: Colors.green.shade200),
                                                  )
                                                ],
                                              ),
                                              onTap: () {
                                                _Rank(index, Ranklist);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 60,
                                        width: 1,
                                        color: index%2==0? Colours.line:Colors.white,
                                      )
                                    ],
                                  ),
                                ),


                            onTap: (){
                              NavigatorUtil.pushPage(context,instructor_demeanor_detail(id:Ranklist[index].id));
                            },
                          );
                        })
          ],
        ));
  }
}
