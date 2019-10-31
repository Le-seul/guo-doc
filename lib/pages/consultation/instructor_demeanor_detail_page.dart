import 'package:flutter/material.dart';
import 'package:flutter_first/bean/psyteacherlist.dart';
import 'package:flutter_first/res/colors.dart';
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
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.only(left: 20),
            height: ScreenUtil().setHeight(21),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  flex:2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                            height: ScreenUtil().setHeight(14),
                            width: ScreenUtil().setHeight(14),
                            decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(widget.list.showId1),fit: BoxFit.fill),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                            height: ScreenUtil().setHeight(14),
                            width: ScreenUtil().setHeight(14),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(widget.list.showId2),fit: BoxFit.fill),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                            height: ScreenUtil().setHeight(14),
                            width: ScreenUtil().setHeight(14),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(widget.list.showId3),fit: BoxFit.fill),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                            height: ScreenUtil().setHeight(14),
                            width: ScreenUtil().setHeight(14),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(widget.list.showId4),fit: BoxFit.fill),
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
        ],
      )
    );

  }
}
