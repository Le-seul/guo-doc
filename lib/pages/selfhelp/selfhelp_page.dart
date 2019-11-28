import 'package:flutter/material.dart';
import 'package:flutter_first/bean/CoreadingLike.dart';
import 'package:flutter_first/bean/coreading.dart';
import 'package:flutter_first/bean/course.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/bean/psycourse.dart';
import 'package:flutter_first/bean/psydailytest.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/home_widgets/coreading/coreading_page.dart';
import 'package:flutter_first/pages/home/home_widgets/course/course_detail_page.dart';
import 'package:flutter_first/pages/home/home_widgets/course/course_page.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/everydaytestpage.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/first.dart';
import 'package:flutter_first/pages/home/home_widgets/music_list_page.dart';
import 'package:flutter_first/pages/home/home_widgets/music_page.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelfHelpPage extends StatefulWidget {
  @override
  _SelfHelpPageState createState() => _SelfHelpPageState();
}

class _SelfHelpPageState extends State<SelfHelpPage> {
  List<PsyDailyTest> PsyList = List();
  bool isShowLoading1 = true;
  bool isShowLoading2 = true;
  bool isShowLoading3 = true;
  bool isShowLoading4 = true;

  List<Course> mycourselist = List(); //我的课程
  List<GetAllMusic> GetAllMusicList = List();
  List<CoReading> list = List(); //共读

  @override
  void initState() {
    //生命周期函数,固定写法
    _requestData();
    _requestPsycourse();
    _getAllMusicList();
    _requestCoreading('');
  }


  void _requestData() {
    DioUtils.instance.requestNetwork<PsyDailyTest>(Method.get, Api.PsyDailyTest,
        isList: true, onSuccessList: (data) {
          setState(() {
            PsyList = data;
            isShowLoading1 = false;
            print(PsyList);
          });
        }, onError: (code, msg) {
          print("sssss");
        });
  }

  void _requestPsycourse() {
    DioUtils.instance.requestNetwork<Course>(Method.get, Api.GETALLCOUTSE,
        isList: true, onSuccessList: (data) {
          setState(() {
            mycourselist = data;
            isShowLoading2 = false;
//            for (Psycourse index in psycourselist) {
//              if (index.categoryId == "轮播图") {
//                mycourselist.add(index);
//              }
//            }
          });
        }, onError: (code, msg) {
          print("sssss");
        });
  }

  _getAllMusicList() {
    DioUtils.instance.requestNetwork<GetAllMusic>(
        Method.get, Api.GETAllMUSICLIST,
        queryParameters: {"pageSize": 3, "pageNumber": 1},
        isList: true, onSuccessList: (data) {
      setState(() {
        GetAllMusicList = data;
        isShowLoading3 = false;
      });
    }, onError: (code, msg) {
      Toast.show('请求失败！');
    });
  }
  void _requestCoreading(String Kind) {
    DioUtils.instance.requestNetwork<CoReading>(Method.get,
        Kind==''? Api.CoReading:Api.CoReadingKind,
        queryParameters: {'categoryId': Kind},
        isList: true, onSuccessList: (data) {
          setState(() {
            list = data;
            isShowLoading4 = false;

          });
        }, onError: (code, msg) {
          print("sssss");
        });
  }
  _getCoreadingLike(String id ) {
    DioUtils.instance
        .requestNetwork<CoreadingLike>(Method.get,
        Api.CoReadingLike,
        queryParameters: {
          'id': id,
        },
        isList: true, onSuccessList: (data) {
          setState(() {

          });
        }, onError: (code, msg) {
          setState(() {
          });
        });
  }
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);
    return Scaffold(
      backgroundColor: Colours.line,
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
            color: Colors.white,
            height:  ScreenUtil().setHeight(7),
            alignment: Alignment.center,
            child: Text(
              '自助',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ), //自助
          Container(
            padding:EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),bottom: 15 ),
            child: Row(
              children: <Widget>[
                Container(
                  color: Colours.bg_green,
                  height: ScreenUtil().setHeight(3),
                  width: ScreenUtil().setWidth(1.2),
                ),
                Text('   趣味自测',style: TextStyle(fontSize: 16.5),),
                SizedBox(width: ScreenUtil().setWidth(57),),
                InkWell(
                  child:Container(child: Text('更多>',style: TextStyle(fontSize: 12,color: Color(0xff6C6C6C)),)),
                  onTap: (){
                    NavigatorUtil.pushPage(context,EverydayTest());
                  },
                )
              ],
            ),),
          Container(
            margin: EdgeInsets.all(10),
            height: ScreenUtil().setHeight(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child:isShowLoading1
                ? LoadingWidget.childWidget()
                : (PsyList.length == 0)
                ? Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Text('暂无数据'),
            )
                :  InkWell(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            image: DecorationImage(
                                image: NetworkImage(PsyList[0].coverImgId),fit: BoxFit.fill
                            )
                        )
                    ),
                    flex: 4,),
                  Expanded(flex: 3,child:
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                        color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.only(left:10 ),
                          child:Text(PsyList[0].title,style: TextStyle(fontSize: 18),),),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.only(left:10 ),
                          child:Text(PsyList[0].shortDesc,style: TextStyle(color: Colors.grey.shade600),),
                        )
                      ],
                    ),
                  ),)
                ],
              ),
              onTap: (){
                NavigatorUtil.pushPage(context,Test0(Url: PsyList[0].testEntry,));
              },
            )
          ),
          Container(
            padding:EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),bottom: 15 ),
            child: Row(
              children: <Widget>[
                Container(
                  color: Colours.bg_green,
                  height: ScreenUtil().setHeight(3),
                  width: ScreenUtil().setWidth(1.2),
                ),
                Text('   心理课程',style: TextStyle(fontSize: 16.5),),
                SizedBox(width: ScreenUtil().setWidth(57),),
                InkWell(
                  child:Container(child: Text('更多>',style: TextStyle(fontSize: 12,color: Color(0xff6C6C6C))),),
                  onTap: (){
                    NavigatorUtil.pushPage(context, PsyCourse());
                  },
                )

              ],
            ),),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: isShowLoading2
                ? LoadingWidget.childWidget()
                : (mycourselist.length == 0)
                ? Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Text('暂无数据'),
            )
                : Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    NavigatorUtil.pushPage(context,CourseDetailPage(courseId: mycourselist[0].id,));
                  },
                  child:Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 200,
                    width: 153,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(mycourselist[0].coverImage),fit: BoxFit.fitHeight),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                            color: Colors.black54 ,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 12,),
                            Text('    如何调节负面情绪',style: TextStyle(color: Colors.white,fontSize: 14),),
                            SizedBox(height: 6,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('     共16讲    ',style: TextStyle(color: Colors.white,fontSize: 11.5),),
                                Icon(Icons.play_circle_outline,size: 16,color: Colors.white,)
                              ],)


                          ],
                        ),

                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    NavigatorUtil.pushPage(context,CourseDetailPage(courseId: mycourselist[1].id,));
                  },
                  child:Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 200,
                    width: 153,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(mycourselist[1].coverImage),fit: BoxFit.fitHeight),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                            color: Colors.black54 ,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 12,),
                            Text('    如何调节负面情绪',style: TextStyle(color: Colors.white,fontSize: 14),),
                            SizedBox(height: 6,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('     共16讲    ',style: TextStyle(color: Colors.white,fontSize: 11.5),),
                                Icon(Icons.play_circle_outline,size: 16,color: Colors.white,)
                              ],)


                          ],
                        ),

                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    NavigatorUtil.pushPage(context,CourseDetailPage(courseId: mycourselist[2].id,));

                  },
                  child:Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 200,
                    width: 153,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(mycourselist[2].coverImage),fit: BoxFit.fitHeight),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                            color: Colors.black54 ,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 12,),
                            Text('    如何调节负面情绪',style: TextStyle(color: Colors.white,fontSize: 14),),
                            SizedBox(height: 6,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('     共16讲    ',style: TextStyle(color: Colors.white,fontSize: 11.5),),
                                Icon(Icons.play_circle_outline,size: 16,color: Colors.white,)
                              ],)


                          ],
                        ),

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),bottom: 15 ),
            child: Row(
              children: <Widget>[
                Container(
                  color: Colours.bg_green,
                  height: ScreenUtil().setHeight(3),
                  width: ScreenUtil().setWidth(1.2),
                ),
                Text('   轻松音乐',style: TextStyle(fontSize: 16.5),),
                SizedBox(width: ScreenUtil().setWidth(57),),
                InkWell(
                  child:Container(child: Text('更多>',style: TextStyle(fontSize: 12,color: Color(0xff6C6C6C))),),
                  onTap: (){
                    NavigatorUtil.pushPage(context,MusicPage(num: 0,tagId: ''));
                  },
                )
              ],
            ),),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    InkWell(
                      child:Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 153,
                        width: 153,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(GetAllMusicList[0].image),fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Align(
                          alignment: Alignment(-0.7,0.8),
                          child: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
                        ),
                      ),
                      onTap: (){
                        NavigatorUtil.pushPage(context,MusicListPage(allMusicList: GetAllMusicList[0]));
                      },
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 10,top: 15),
                      child: Text(GetAllMusicList[0].name,style: TextStyle(fontSize: 15),),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10,top: 9),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.headset,color: Colors.grey,size: 15,),
                            Text('  2518',style: TextStyle(color: Colors.grey,),)
                          ],
                        )
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      child:Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 153,
                        width: 153,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(GetAllMusicList[1].image),fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Align(
                          alignment: Alignment(-0.7,0.8),
                          child: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
                        ),
                      ),
                      onTap: (){
                        NavigatorUtil.pushPage(context,MusicListPage(allMusicList: GetAllMusicList[1]));
                      },
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 10,top: 15),
                      child: Text(GetAllMusicList[1].name,style: TextStyle(fontSize: 15),),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10,top: 9),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.headset,color: Colors.grey,size: 15,),
                            Text('  2518',style: TextStyle(color: Colors.grey,),)
                          ],
                        )
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      child:Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 153,
                        width: 153,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(GetAllMusicList[2].image),fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Align(
                          alignment: Alignment(-0.7,0.8),
                          child: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
                        ),
                      ),
                      onTap: (){
                        NavigatorUtil.pushPage(context,MusicListPage(allMusicList: GetAllMusicList[2],));
                      },
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 10,top: 15),
                      child: Text(GetAllMusicList[2].name,style: TextStyle(fontSize: 15),),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10,top: 9),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.headset,color: Colors.grey,size: 15,),
                            Text('  2518',style: TextStyle(color: Colors.grey,),)
                          ],
                        )
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
            ),
          ),
          Container(
            padding:EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),bottom: 15 ),
            child: Row(
              children: <Widget>[
                Container(
                  color: Colours.bg_green,
                  height: ScreenUtil().setHeight(3),
                  width: ScreenUtil().setWidth(1.2),
                ),
                Text('   心理共读',style: TextStyle(fontSize: 16.5),),
                SizedBox(width: ScreenUtil().setWidth(57),),
                InkWell(
                  child:Container(child: Text('更多>',style: TextStyle(fontSize: 12,color: Color(0xff6C6C6C)),)),
                  onTap: (){
                    NavigatorUtil.pushPage(context,SimpleCoreading());
                  },
                )
              ],
            ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Container(
                      margin: EdgeInsets.all(5),
                      height: ScreenUtil().setHeight(4.5),
                      width: ScreenUtil().setHeight(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15),
                          ),
                          color: Color(0xffEDF9EB)
                      ),
                      child: Center(
                        child: Text('情绪压力',style: TextStyle(color: Color(0xff919191),fontSize: 12),),
                      )
                  ),
                  onTap: (){
                    setState(() {
                      _requestCoreading('情绪压力');
                    });
                  },
                )
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                      margin: EdgeInsets.all(5),
                      height: ScreenUtil().setHeight(4.5),
                      width: ScreenUtil().setHeight(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15),
                          ),
                          color: Color(0xffFCF5E3)
                      ),
                      child: Center(
                        child: Text('咨询科普',style: TextStyle(color: Color(0xff919191),fontSize: 12),),
                      )
                  ), 
                  onTap: (){
                    setState(() {
                      _requestCoreading('咨询科普');
                    });
                  },
                ),
              ),
              Expanded(
                child: 
                InkWell(
                  child: Container(
                      margin: EdgeInsets.all(5),
                      height: ScreenUtil().setHeight(4.5),
                      width: ScreenUtil().setHeight(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15),
                        ),
                          color: Color(0xffFCF1F5)
                      ),
                      child: Center(
                        child: Text('亲密关系',style: TextStyle(color: Color(0xff919191),fontSize: 12),),
                      )
                  ),
                  onTap: (){
                    setState(() {
                      _requestCoreading('亲密关系');
                    });
                  },
                ),
              ),
              Expanded(
                child:InkWell(
                  child: Container(
                      margin: EdgeInsets.all(5),
                      height: ScreenUtil().setHeight(4.5),
                    width: ScreenUtil().setHeight(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15),
                      ),
                        color: Color(0xffE9EBFD)
                    ),
                    child: Center(
                      child: Text('个人成长',style: TextStyle(color: Color(0xff919191),fontSize: 12),),
                    )
              ),
                  onTap: (){
                    setState(() {
                      _requestCoreading('个人成长');
                    });
                  },
                ), ),
            ],
          ),
          SizedBox(
            height:5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Container(
                      margin: EdgeInsets.all(5),
                      height: ScreenUtil().setHeight(4.5),
                      width: ScreenUtil().setHeight(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15),
                        ),
                          color: Color(0xffEDF9EB)
                      ),
                      child: Center(
                        child: Text('家庭关系',style: TextStyle(color: Color(0xff919191),fontSize: 12),),
                      )
                  ),
                  onTap: (){
                    setState(() {
                      _requestCoreading('个人成长');
                    });                  },
                ),
              ),
              Expanded(
                child:InkWell(
                  child: Container(
                      margin: EdgeInsets.all(5),

                      height: ScreenUtil().setHeight(4.5),
                      width: ScreenUtil().setHeight(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15),
                        ),
                          color: Color(0xffFCF5E3)
                      ),
                      child: Center(
                        child: Text('人际关系',style: TextStyle(color: Color(0xff919191),fontSize: 12),),
                      )
                  ),
                  onTap: (){
                    setState(() {
                      _requestCoreading('个人成长');
                    });                  },
                ), ),
              Expanded(
                child: InkWell(
                  child: Container(
                      margin: EdgeInsets.all(5),

                      height: ScreenUtil().setHeight(4.5),
                      width: ScreenUtil().setHeight(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15),
                        ),
                          color: Color(0xffFCF1F5)
                      ),
                      child: Center(
                        child: Text('亲子关系',style: TextStyle(color: Color(0xff919191),fontSize: 12),),
                      )
                  ),
                  onTap: (){
                    setState(() {
                      _requestCoreading('个人成长');
                    });                  },
                ),
              ),
              Expanded(
                child:InkWell(
                  child: Container(
                      margin: EdgeInsets.all(5),
                      height: ScreenUtil().setHeight(4.5),
                      width: ScreenUtil().setHeight(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15),
                        ),
                          color: Color(0xffE9EBFD)
                      ),
                      child: Center(
                        child: Text('行为关系',style: TextStyle(color: Color(0xff919191),fontSize: 12),),
                      )
                  ),
                  onTap: (){
                    setState(() {
                      _requestCoreading('个人成长');
                    });                  },
                ),
              ),

            ],
          ),
          SizedBox(
            height: 8,
          ),
          isShowLoading4
              ? LoadingWidget.childWidget()
              : (list.length == 0)
              ? Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Text('暂无数据'),
          )
              :ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context , index){
            return InkWell(
              child: Container(
                height: 150,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(23.5, 20, 15, 42.5),
                              color: Color(0xFFFFCDD2),
                            ),
                            Positioned(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 33, 28, 20),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage(list[index].coverImgId),fit: BoxFit.fill)
                                  ),
                                ))
                          ],
                        )
                    ),
                    Expanded(
                      flex: 2,child:
                    Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 23,),
                        Text(list[index].name,style: TextStyle(fontSize: 18),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.star,color:  Color(0xffFF9935),size: 18,),
                            Text('${list[index].learnedUserCount}人在读',style: TextStyle(color:  Color(0xffFF9935))),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: Text(list[index].shortDesc,style: TextStyle(color: Color(0xff919191),fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        ),

                      ],
                    ),),

                  ],
                ),
              ),
              onTap: (){
                _getCoreadingLike(list[index].id);
                NavigatorUtil.pushWebView(context, list[index].detailDesc, {"title":list[index].shortDesc});
              },
            );
          }),
        ],
      ),
    );
  }
}


