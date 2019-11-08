import 'package:flutter/material.dart';
import 'package:flutter_first/bean/course.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/bean/psycourse.dart';
import 'package:flutter_first/bean/psydailytest.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
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

  List<Course> mycourselist = List(); //我的课程
  List<GetAllMusic> GetAllMusicList = List();

  @override
  void initState() {
    //生命周期函数,固定写法
    _requestData();
    _requestPsycourse();
    _getAllMusicList();
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

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);
    return Scaffold(
      backgroundColor: Colours.line,
      body: ListView(
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
                  child:Container(child: Text('更多>',style: TextStyle(fontSize: 13.5),)),
                  onTap: (){
                    Router.pushNoParams(context, Router.everydaytest);
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
                Router.push(context, Router.test0,PsyList[0].testEntry);
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
                  child:Container(child: Text('更多>',style: TextStyle(fontSize: 13.5),)),
                  onTap: (){
                    Router.pushNoParams(context, Router.psycourse);
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
                    Router.push(context, Router.curriculumcatalog1,mycourselist[0].id);
//                    Router.push(context, mycourselist[0].coverImage, {'title': mycourselist[0].name});
                  },
                  child:Container(
                    margin: EdgeInsets.all(10),
                    height: ScreenUtil().setHeight(30),
                    width: ScreenUtil().setHeight(23),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(mycourselist[0].coverImage),fit: BoxFit.fill),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(8),
                        decoration: BoxDecoration(
                            color: Colors.black54 ,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('    如何调节负面情绪',style: TextStyle(color: Colors.white,fontSize: 13.5),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('     共16讲    ',style: TextStyle(color: Colors.white,fontSize: 11.5),),
                                Icon(Icons.play_circle_outline,size: 15,color: Colors.white,)
                              ],)


                          ],
                        ),

                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Router.push(context, Router.curriculumcatalog1,mycourselist[1].id);
//                    Router.push(context, mycourselist[1].coverImage, {'title': mycourselist[1].name});
                  },
                  child:Container(
                    margin: EdgeInsets.all(10),
                    height: ScreenUtil().setHeight(30),
                    width: ScreenUtil().setHeight(23),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(mycourselist[1].coverImage),fit: BoxFit.fill),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(8),
                        decoration: BoxDecoration(
                            color: Colors.black54 ,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('    如何调节负面情绪',style: TextStyle(color: Colors.white,fontSize: 13.5),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('     共16讲    ',style: TextStyle(color: Colors.white,fontSize: 11.5),),
                                Icon(Icons.play_circle_outline,size: 15,color: Colors.white,)
                              ],)


                          ],
                        ),

                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Router.push(context, Router.curriculumcatalog1,mycourselist[2].id);
//                    Router.push(context, mycourselist[2].coverImage, {'title': mycourselist[2].name});
                  },
                  child:Container(
                    margin: EdgeInsets.all(10),
                    height: ScreenUtil().setHeight(30),
                    width: ScreenUtil().setHeight(23),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(mycourselist[2].coverImage),fit: BoxFit.fill),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(8),
                        decoration: BoxDecoration(
                            color: Colors.black54 ,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('    如何调节负面情绪',style: TextStyle(color: Colors.white,fontSize: 13.5),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('     共16讲    ',style: TextStyle(color: Colors.white,fontSize: 11.5),),
                                Icon(Icons.play_circle_outline,size: 15,color: Colors.white,)
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
                  child:Container(child: Text('更多>',style: TextStyle(fontSize: 13.5),)),
                  onTap: (){
                    Router.push(context, Router.musicPage, {'num': 0, 'tagId': ""});
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
                        margin: EdgeInsets.all(10),
                        height: ScreenUtil().setHeight(23),
                        width: ScreenUtil().setHeight(23),
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(GetAllMusicList[0].image),fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Align(
                          alignment: Alignment(-0.7,0.8),
                          child: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
                        ),
                      ),
                      onTap: (){
                        Router.push(context, Router.musicListPage, GetAllMusicList[0]);
                      },
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(GetAllMusicList[0].name,style: TextStyle(fontSize: 15),),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10),
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
                        margin: EdgeInsets.all(10),
                        height: ScreenUtil().setHeight(23),
                        width: ScreenUtil().setHeight(23),
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(GetAllMusicList[1].image),fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Align(
                          alignment: Alignment(-0.7,0.8),
                          child: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
                        ),
                      ),
                      onTap: (){
                        Router.push(context, Router.musicListPage, GetAllMusicList[0]);
                      },
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(GetAllMusicList[1].name,style: TextStyle(fontSize: 15),),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10),
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
                        margin: EdgeInsets.all(10),
                        height: ScreenUtil().setHeight(23),
                        width: ScreenUtil().setHeight(23),
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(GetAllMusicList[2].image),fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Align(
                          alignment: Alignment(-0.7,0.8),
                          child: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
                        ),
                      ),
                      onTap: (){
                        Router.push(context, Router.musicListPage, GetAllMusicList[0]);
                      },
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(GetAllMusicList[2].name,style: TextStyle(fontSize: 15),),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10),
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
//                Column(
//                  children: <Widget>[
//                    InkWell(
//                      child:Container(
//                        margin: EdgeInsets.all(10),
//                        height: ScreenUtil().setHeight(23),
//                        width: ScreenUtil().setHeight(23),
//                        decoration: BoxDecoration(
//                            image: DecorationImage(image: NetworkImage(GetAllMusicList[3].image),fit: BoxFit.fill),
//                            borderRadius: BorderRadius.all(Radius.circular(5))
//                        ),
//                        child: Align(
//                          alignment: Alignment(-0.7,0.8),
//                          child: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
//                        ),
//                      ),
//                      onTap: (){
//                        Router.push(context, Router.musicListPage, GetAllMusicList[3]);
//                      },
//                    ),
//
//                    Container(
//                      padding: EdgeInsets.only(left: 10),
//                      child: Text(GetAllMusicList[3].name,style: TextStyle(fontSize: 15),),
//                    ),
//                    Container(
//                        padding: EdgeInsets.only(left: 10),
//                        child: Row(
//                          children: <Widget>[
//                            Icon(Icons.headset,color: Colors.grey,size: 15,),
//                            Text('  2518',style: TextStyle(color: Colors.grey,),)
//                          ],
//                        )
//                    ),
//                  ],
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                ),
//                Column(
//                  children: <Widget>[
//                    InkWell(
//                      child:Container(
//                        margin: EdgeInsets.all(10),
//                        height: ScreenUtil().setHeight(23),
//                        width: ScreenUtil().setHeight(23),
//                        decoration: BoxDecoration(
//                            image: DecorationImage(image: NetworkImage(GetAllMusicList[4].image),fit: BoxFit.fill),
//                            borderRadius: BorderRadius.all(Radius.circular(5))
//                        ),
//                        child: Align(
//                          alignment: Alignment(-0.7,0.8),
//                          child: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
//                        ),
//                      ),
//                      onTap: (){
//                        Router.push(context, Router.musicListPage, GetAllMusicList[4]);
//                      },
//                    ),
//
//                    Container(
//                      padding: EdgeInsets.only(left: 10),
//                      child: Text(GetAllMusicList[4].name,style: TextStyle(fontSize: 15),),
//                    ),
//                    Container(
//                        padding: EdgeInsets.only(left: 10),
//                        child: Row(
//                          children: <Widget>[
//                            Icon(Icons.headset,color: Colors.grey,size: 15,),
//                            Text('  2518',style: TextStyle(color: Colors.grey,),)
//                          ],
//                        )
//                    ),
//                  ],
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                ),
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
                Text('   心理共读',style: TextStyle(fontSize: 16.5),)
              ],
            ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.green.shade200,
                  ),
                  child: Center(
                    child: Text('情绪压力',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),
              SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.orange.shade200,
                  ),
                  child: Center(
                    child: Text('咨询科普',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),
              SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.deepOrange.shade200,
                  ),
                  child: Center(
                    child: Text('亲密关系',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),
              SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.green.shade200,
                  ),
                  child: Center(
                    child: Text('个人成长',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),
              SizedBox(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.green.shade200,
                  ),
                  child: Center(
                    child: Text('家庭关系',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),
              SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.orange.shade200,
                  ),
                  child: Center(
                    child: Text('人际关系',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),
              SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.deepOrange.shade200,
                  ),
                  child: Center(
                    child: Text('亲子关系',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),
              SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.green.shade200,
                  ),
                  child: Center(
                    child: Text('行为关系',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),
              SizedBox(),

            ],
          ),
          SizedBox(
            height: 13,
          ),
          Container(
            height: ScreenUtil().setHeight(25),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex: 1,child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('https://ss1.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=328381647,2298442252&fm=26&gp=0.jpg'))
                  ),
                )),
                Expanded(flex: 2,child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Text('如何做到喜欢自己',style: TextStyle(fontSize: 18),),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star,color: Colors.orange,),
                        Text('  205人在读',style: TextStyle(color: Colors.orange),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('这是内容',style: TextStyle(color: Colors.grey.shade600))
                  ],
                ),),

              ],
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(25),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex: 1,child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('http://b-ssl.duitang.com/uploads/item/201610/12/20161012150657_2GTru.thumb.700_0.jpeg'))
                  ),
                )),
                Expanded(flex: 2,child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Text('我和世界爱着你',style: TextStyle(fontSize: 18),),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star,color: Colors.orange,),
                        Text('  205人在读',style: TextStyle(color: Colors.orange),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('这是内容',style: TextStyle(color: Colors.grey.shade600))
                  ],
                ),),

              ],
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(25),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex: 1,child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('http://www.wndhw.com/fengjing/zhaopian/images/zp016t13.jpg'))
                  ),
                )),
                Expanded(flex: 2,child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Text('学会调节情绪',style: TextStyle(fontSize: 18),),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star,color: Colors.orange,),
                        Text('  205人在读',style: TextStyle(color: Colors.orange),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('这是内容',style: TextStyle(color: Colors.grey.shade600))
                  ],
                ),),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


