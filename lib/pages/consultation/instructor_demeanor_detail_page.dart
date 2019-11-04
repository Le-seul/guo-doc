import 'package:flutter/material.dart';
import 'package:flutter_first/bean/psyteacherlist.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class instructor_demeanor_detail extends StatefulWidget {
  PsyTeacherList list;

  instructor_demeanor_detail({Key key, @required this.list})
      : super(key: key);
  @override
  _instructor_demeanor_detailState createState() => _instructor_demeanor_detailState();
}

class _instructor_demeanor_detailState extends State<instructor_demeanor_detail> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return Scaffold(
      backgroundColor: Colours.line,
      appBar: AppBar(
        title: Text('教官风采',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black,size: 32),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            height: ScreenUtil().setHeight(18),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(flex: 2,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: ClipOval(
                    child: Image.network(widget.list.imgId),
                  ),
                ),),
                Expanded(flex: 5,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(

                      child: Text(widget.list.name,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500 ),),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.list.orgId,style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13
                          ),),
                          Text(widget.list.shortDesc,style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13
                          ),)
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.only(left: 20),
            height: ScreenUtil().setHeight(14),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('心理服务格言',style: TextStyle(fontSize: 16)),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:Text(widget.list.slogan,style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13
                    ),),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.only(left: 20),
            height: ScreenUtil().setHeight(14),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('特长.专长(研究方向.教学方向)',style: TextStyle(fontSize: 16)),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:Text(widget.list.major,style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13
                    ),),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.only(left: 20),
            height: ScreenUtil().setHeight(37),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('风采展示',style: TextStyle(fontSize: 16)),
                  ),
                ),
                Expanded(
                  flex:3,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                            height: ScreenUtil().setHeight(20),
                            width: ScreenUtil().setHeight(20),
                            decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(widget.list.showId1),fit: BoxFit.fill),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                            height: ScreenUtil().setHeight(20),
                            width: ScreenUtil().setHeight(20),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(widget.list.showId2),fit: BoxFit.fill),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                            height: ScreenUtil().setHeight(20),
                            width: ScreenUtil().setHeight(20),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(widget.list.showId3),fit: BoxFit.fill),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),

                        ],
                      ),
                  )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.only(left: 20),
            height: ScreenUtil().setHeight(20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('参与培训及服务情况',style: TextStyle(fontSize: 16)),
                  ),
                ),
                Expanded(
                  flex:2,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:Text(widget.list.detailDesc,style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13
                    ),),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20,top: 10),
          color: Colors.white,
          child: Text('相关资讯',style: TextStyle(fontSize: 16),),),
          GestureDetector(
            child:Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 1),
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), 15, ScreenUtil().setWidth(5), 15),
              height: ScreenUtil().setHeight(20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/consultation/中心1.png',fit: BoxFit.fill),
                    height: ScreenUtil().setHeight(13),
                    width: ScreenUtil().setHeight(18),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 13),),
                          SizedBox(height: 5,),
                          Container(
                            child:Text('心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 12,color: Colors.grey),softWrap: true,maxLines: 3,),
                          )
                        ],
                      ),
                    ),)

                ],
              ),
            ),
            onTap: (){Router.push(context, 'http://news.cpd.com.cn/n18151/201910/t20191030_862809.html',{"title":'时事新闻'});},
          ),
          GestureDetector(
            child:Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 1),
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), 15, ScreenUtil().setWidth(5), 15),
              height: ScreenUtil().setHeight(20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/consultation/中心2.png',fit: BoxFit.fill),
                    height: ScreenUtil().setHeight(13),
                    width: ScreenUtil().setHeight(18),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 13),),
                          SizedBox(height: 5,),
                          Container(
                            child:Text('心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 12,color: Colors.grey),softWrap: true,maxLines: 3,),
                          )
                        ],
                      ),
                    ),)

                ],
              ),
            ),
            onTap: (){Router.push(context, 'http://news.cpd.com.cn/n18151/201910/t20191030_862812.html',{"title":'时事新闻'});},
          ),
          GestureDetector(
            child:Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 1),
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), 15, ScreenUtil().setWidth(5), 15),
              height: ScreenUtil().setHeight(20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/consultation/中心3.png',fit: BoxFit.fill),
                    height: ScreenUtil().setHeight(13),
                    width: ScreenUtil().setHeight(18),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 13),),
                          SizedBox(height: 5,),
                          Container(
                            child:Text('心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 12,color: Colors.grey),softWrap: true,maxLines: 3,),
                          )
                        ],
                      ),
                    ),)

                ],
              ),
            ),
            onTap: (){Router.push(context, 'http://news.cpd.com.cn/n18151/201910/t20191030_862813.html',{"title":'时事新闻'});},
          ),
        ],
      )
    );

  }
}
