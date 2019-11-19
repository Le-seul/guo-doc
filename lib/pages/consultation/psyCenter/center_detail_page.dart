import 'package:flutter/material.dart';
import 'package:flutter_first/bean/centerdetail_page.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PsyCenterDetail extends StatefulWidget {
  dynamic id;
  PsyCenterDetail({Key key, @required this.id})
      : super(key: key);
  @override
  _PsyCenterDetailState createState() => _PsyCenterDetailState();
}

class _PsyCenterDetailState extends State<PsyCenterDetail> {
  List<CenterDetail> list = List();
  bool isShowLoading = true;

  @override
  void initState() {
    _getServiceCenter();
  }

  _getServiceCenter() {
    DioUtils.instance
        .requestNetwork<CenterDetail>(Method.get,
        Api.GETPSYSERVICECENTERDETAIL,
        queryParameters: {
          'id': widget.id.toString(),
        },
        isList: true, onSuccessList: (data) {
          setState(() {
            list = data;
            isShowLoading = false;
            print("数据是"+list[0].name);
        print('获取服务中心详情成功!');
          });
        }, onError: (code, msg) {
          setState(() {
        print('获取服务中心详情失败!');
          });
        });
  }

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
      body: Container(
        child: Container(
          child: isShowLoading
              ? LoadingWidget.childWidget()
              : list.length == 0
              ? Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Text('暂无数据'),
          )
              :ListView(

            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                 height:  ScreenUtil().setHeight(15),
                 color:Colors.white,
                 child: Stack(
                    children: <Widget>[
                      Container(
                        height:  ScreenUtil().setHeight(10),
                        color:Colours.bg_green,
                      ),
                      Positioned(
                          bottom: ScreenUtil().setHeight(0),
                        left:ScreenUtil().setWidth(5),
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: ClipOval(
                              child: Image.network(list[0].imgId,height: 65,),
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
                    Text(list[0].name,style: TextStyle(fontSize: 16),),
                    SizedBox(
                      height: ScreenUtil().setWidth(2),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.home,color: Colours.bg_green,size: 18,),
                        Text('  '+list[0].location,style: TextStyle(color: Colors.grey),)
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setWidth(1),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.timer,color: Colours.bg_green,size: 18,),
                        Text('  '+list[0].conTime,style: TextStyle(color: Colors.grey),)
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setWidth(1),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.headset,color: Colours.bg_green,size: 18,),
                        Text('  '+list[0].contacts,style: TextStyle(color: Colors.grey),)
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setWidth(1),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.phone,color: Colours.bg_green,size: 18,),
                        Text('  '+list[0].phone,style: TextStyle(color: Colors.grey),)
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
                    Text(list[0].shortDesc,style: TextStyle(fontSize: 14),maxLines: 2,overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
              Container(
                height:ScreenUtil().setHeight(2),
              ),
              widget.id=="1"?Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),right: ScreenUtil().setWidth(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text('总体概况',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                      margin: EdgeInsets.only(top: 5,bottom: 10),),
                    Container(
                      height: ScreenUtil().setHeight(400),
                      child: WebView(
                        initialUrl:list[0].detailDesc,
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
                    )
                  ],
                ),

              ):
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
              Container(
                  padding:EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),bottom: 15 ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        color: Colours.bg_green,
                        height: ScreenUtil().setHeight(3),
                        width: ScreenUtil().setWidth(1.5),
                      ),
                      Text('   相关资讯',style: TextStyle(fontSize: 16.5),)
                    ],
                  ),),

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
          ),
        ),
      ),
    );
  }
}
