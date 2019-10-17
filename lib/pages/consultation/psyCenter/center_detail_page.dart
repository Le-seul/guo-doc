import 'package:flutter/material.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PsyCenterDetail extends StatefulWidget {
  @override
  _PsyCenterDetailState createState() => _PsyCenterDetailState();
}

class _PsyCenterDetailState extends State<PsyCenterDetail> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);
    return Scaffold(

      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colours.bg_green,
        title: Text('中心详情',style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colours.line,
      body: ListView(

        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
             height:  ScreenUtil().setHeight(23),
             color:Colors.white,
             child: Stack(
                children: <Widget>[
                  Container(
                    height:  ScreenUtil().setHeight(18),
                    color:Colours.bg_green,
                  ),
                  Positioned(
                      bottom: ScreenUtil().setHeight(0),
                    left:ScreenUtil().setWidth(5),
                      child: Container(
                        padding: EdgeInsets.all(0),
                        child: ClipOval(
                          child: Image.network('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=683097614,4071607410&fm=26&gp=0.jpg',height: 65,),
                        ),
                      ),)
                ],
              ),
           ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),bottom: 15 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('房山分局心理服务分中心',style: TextStyle(fontSize: 16),),
                SizedBox(
                  height: ScreenUtil().setWidth(2),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.home,color: Colours.bg_green,size: 18,),
                    Text('  房山分局机关楼一层',style: TextStyle(color: Colors.grey),)
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setWidth(1),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.timer,color: Colours.bg_green,size: 18,),
                    Text('  周一到周日 9.00-22.00',style: TextStyle(color: Colors.grey),)
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setWidth(1),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.headset,color: Colours.bg_green,size: 18,),
                    Text('  李梦妍',style: TextStyle(color: Colors.grey),)
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setWidth(1),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.phone,color: Colours.bg_green,size: 18,),
                    Text('  81389354',style: TextStyle(color: Colors.grey),)
                  ],
                ),
              ],
            ),
          ),
          Container(
            height:ScreenUtil().setHeight(2),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 10,left:ScreenUtil().setWidth(5),bottom: 15 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('功能室情况',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,),),
                SizedBox(
                  height: ScreenUtil().setWidth(2),
                ),
                Text('日均访问人数30人',style: TextStyle(fontSize: 14))
              ],
            ),
          ),
          Container(
            height:ScreenUtil().setHeight(2),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),right: ScreenUtil().setWidth(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Text('总体概况',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                margin: EdgeInsets.only(top: 5,bottom: 10),),
                Container(
                  margin: EdgeInsets.only(top: 5,bottom: 10),
                  height:ScreenUtil().setHeight(32),
                  width:ScreenUtil().setWidth(90) ,
                  child: Image.asset('assets/images/consultation/中心1.png',fit: BoxFit.fill,),
                ),
                Container(
                  child: Text('接待室',style: TextStyle(fontSize: 14),),
                  margin: EdgeInsets.only(top: 5,bottom: 10),),
                Container(
                  child: Text('配备了监督管理公共信息网络的安全监察工作；指导和监督国家机关、社会团体、企业事业组织和重点建设工程的治安保卫工作，指导治安保卫委员会等群众性治安保卫组织的治安防范工作。',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w200,height: 1.5),),
                  margin: EdgeInsets.only(top: 5,bottom: 10),),
                Container(
                  margin: EdgeInsets.only(top: 5,bottom: 10),
                  height:ScreenUtil().setHeight(32),
                  width:ScreenUtil().setWidth(90) ,
                  child: Image.asset('assets/images/consultation/中心2.png',fit: BoxFit.fill,),
                ),
                Container(
                  child: Text('接待室',style: TextStyle(fontSize: 14),),
                  margin: EdgeInsets.only(top: 5,bottom: 10),),
                Container(
                  child: Text('配备了监督管理公共信息网络的安全监察工作；指导和监督国家机关、社会团体、企业事业组织和重点建设工程的治安保卫工作，指导治安保卫委员会等群众性治安保卫组织的治安防范工作。',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w200,height: 1.5),),
                  margin: EdgeInsets.only(top: 5,bottom: 10),),
                Container(
                  margin: EdgeInsets.only(top: 5,bottom: 10),
                  height:ScreenUtil().setHeight(32),
                  width:ScreenUtil().setWidth(90) ,
                  child: Image.asset('assets/images/consultation/中心3.png',fit: BoxFit.fill,),
                ),
                Container(
                  child: Text('接待室',style: TextStyle(fontSize: 14),),
                  margin: EdgeInsets.only(top: 5,bottom: 10),),
                Container(
                  child: Text('配备了监督管理公共信息网络的安全监察工作；指导和监督国家机关、社会团体、企业事业组织和重点建设工程的治安保卫工作，指导治安保卫委员会等群众性治安保卫组织的治安防范工作。',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w200,height: 1.5),),
                  margin: EdgeInsets.only(top: 5,bottom: 10),),
              ],
            ),

          ),


        ],
      ),
    );
  }
}
