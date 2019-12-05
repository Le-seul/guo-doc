import 'package:flutter/material.dart';
import 'package:flutter_first/bean/clinic_info.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/widgets/loading_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Clinic_information extends StatefulWidget {
  @override
  _Clinic_informationState createState() => _Clinic_informationState();
}

class _Clinic_informationState extends State<Clinic_information> {
  List<Clinic> list = List();
  bool isShowLoading = true;
  void initState(){
    _requestClinic();
  }

  @override
  void _requestClinic() {
    DioUtils.instance.requestNetwork<Clinic>(
        Method.get, Api.CLINICINFO,
        isList: true, onSuccessList: (data) {
      setState(() {
        print('教官成功');
        list = data;
        isShowLoading = false;
      });
    }, onError: (code, msg) {
      print('教官失败');
    });
  }
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text('门诊信息',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black,size: 32),
      ),
      backgroundColor: Colours.line,
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : (list.length == 0)
          ? Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text('暂无数据'),
      )
          :GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85
          ),
          itemCount: list.length,
          itemBuilder: (BuildContext context,int index){
            return InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Expanded(flex: 6,child:
                    Container(decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(list[index].imgId),fit: BoxFit.fill)
                    ),)),
                    Expanded(flex: 2,
                        child: Column(
                          children: <Widget>[
                            Expanded(child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(list[index].name,style: TextStyle(fontWeight:FontWeight.w600 ),),
                                  SizedBox(width:ScreenUtil().setWidth(3),),
                                  Text(list[index].post,style: TextStyle(fontSize: 11),)
                                ],
                              ),
                              alignment: Alignment.centerLeft,
                            )),
                            Expanded(child: Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.topLeft,
                              child: Text('出诊时间:'+list[index].workTime,style: TextStyle(fontSize: 11,color: Colors.grey),maxLines: 1,overflow:TextOverflow.ellipsis ,),)),

                          ],
                        )
                    ),

                  ],
                ),
              ),
              onTap: (){
                NavigatorUtil.pushWebView(context, "http://49.232.168.124/phms_resource_base/clinicInfo/GJH.html", {'title':'详情'});
              },
            );
          }),
    );
  }
}
