import 'package:flutter/material.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/my_card.dart';

class DoctorChunyuHomePage extends StatefulWidget {
  @override
  _DoctorChunyuHomePageState createState() => _DoctorChunyuHomePageState();
}

class _DoctorChunyuHomePageState extends State<DoctorChunyuHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height*360/667,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/doctor/bg_doctor.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 35,
                      ),
                      Center(
                        child: Text(
                          '首页',
                          style: TextStyle(fontSize: 22.0, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            child: MyCard(
                                child: Container(
                                  height: MediaQuery.of(context).size.height*260/667,
                                  padding: EdgeInsets.only(left:15.0,right: 15.0,top: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '服务说明',
                                        style: TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明服务说明务说明服务说明服务说明服务说明服务说明服务说明务说明服务说明服务说明',
                                        strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5,),
                                        style: TextStyle(fontSize: 14,),
                                        maxLines: 7,
                                      )
                                    ],
                                  ),)),
                          ))
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  crossAxisCount: 2,
                  childAspectRatio: 163/120,
                  children: <Widget>[
                    GestureDetector(
                      child: _gridItem('assets/images/doctor/graphic_consultation.png', 'doctor/graphic_icon.png', '图文咨询'),
                      onTap: (){
                      Router.pushNoParams(context, Router.graphicConsultation);
                      },
                    ),
                    GestureDetector(
                      child: _gridItem('assets/images/doctor/quick_phone.png', 'doctor/phone_icon.png', '快捷电话'),
                      onTap: (){
                        Router.pushNoParams(context, Router.telConsultation);
                      },
                    ),
                    GestureDetector(
                      child: _gridItem('assets/images/doctor/search_hospital.png', 'doctor/hospital_icon.png', '找医院'),
                      onTap: (){
                        Router.pushNoParams(context, Router.searchHospital);
                      },
                    ),
                    GestureDetector(
                      child: _gridItem('assets/images/doctor/historical_record.png', 'doctor/history_icon.png', '历史记录'),
                      onTap: (){
                        Router.pushNoParams(context, Router.historyRecord);
                      },
                    ),

                  ],
                ),
              )
            ],
          ),
    );
  }
  _gridItem(String bgImage,String icon,String text){
    return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            image: DecorationImage(
                image: AssetImage(bgImage),
                fit: BoxFit.fill),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                loadAssetImage(icon,color: Colors.white,height: 40,width: 40),
                SizedBox(height: 16,),
                Text(text,style: TextStyle(fontSize: 18,color: Colors.white),),
              ],
            ),
          )
        );
  }
}
