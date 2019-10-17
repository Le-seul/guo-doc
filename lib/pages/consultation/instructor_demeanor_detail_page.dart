import 'package:flutter/material.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class instructor_demeanor_detail extends StatefulWidget {
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
                    child: Image.network('https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2080823830,3911438045&fm=26&gp=0.jpg'),
                  ),
                ),),
                Expanded(flex: 5,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(

                      child: Text('周警官',style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500 ),),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('第十二总队',style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13
                          ),),
                          Text('国家二级心理咨询师',style: TextStyle(
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
                    child:Text('凡是经历,皆为馈赠,美好的事情即将发生.',style: TextStyle(
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
                    child:Text('团队心理辅导,一对一面询心理辅导,表达性艺术治疗,心理剧.',style: TextStyle(
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
                    child:Text('多次参与警报部门组织的心理辅导',style: TextStyle(
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
                              image: DecorationImage(image: NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2250972642,639062800&fm=26&gp=0.jpg',),fit: BoxFit.fill),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                            height: ScreenUtil().setHeight(14),
                            width: ScreenUtil().setHeight(14),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage('https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3656379531,1504573929&fm=26&gp=0.jpg',),fit: BoxFit.fill),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                            height: ScreenUtil().setHeight(14),
                            width: ScreenUtil().setHeight(14),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=240458001,4127833211&fm=26&gp=0.jpg',),fit: BoxFit.fill),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                            height: ScreenUtil().setHeight(14),
                            width: ScreenUtil().setHeight(14),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage('https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2094498554,979970116&fm=26&gp=0.jpg',),fit: BoxFit.fill),
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
