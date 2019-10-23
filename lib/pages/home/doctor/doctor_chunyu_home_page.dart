import 'package:flutter/material.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/top_panel.dart';

class DoctorChunyuHomePage extends StatefulWidget {
  @override
  _DoctorChunyuHomePageState createState() => _DoctorChunyuHomePageState();
}

class _DoctorChunyuHomePageState extends State<DoctorChunyuHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LoginTopPanel(),
          Column(
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
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    child: MyCard(
                        child: Container(
                      height: MediaQuery.of(context).size.height * 260 / 667,
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
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
                            strutStyle: StrutStyle(
                              forceStrutHeight: true,
                              height: 1.5,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            maxLines: 7,
                          )
                        ],
                      ),
                    )),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: _gridItem(
                            'assets/images/doctor/graphic_consultation.png',
                            'doctor/graphic_icon.png',
                            '图文咨询'),
                        onTap: () {
                          Router.pushNoParams(
                              context, Router.graphicConsultation);

                          showMySimpleDialog(context);
                        },
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: _gridItem('assets/images/doctor/quick_phone.png',
                            'doctor/phone_icon.png', '快捷电话'),
                        onTap: () {
                          Router.pushNoParams(context, Router.telConsultation);
                        },
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: _gridItem(
                            'assets/images/doctor/historical_record.png',
                            'doctor/history_icon.png',
                            '历史记录'),
                        onTap: () {
                          Router.pushNoParams(context, Router.historyRecord);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showMySimpleDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new SimpleDialog(
            title: new Text("咨询问题"),
            children: <Widget>[
              new SimpleDialogOption(
                child: new Text("正在咨询2"),
                onPressed: () {
                  Router.pushNoParams(context, Router.historyRecord);
                },
              ),
              new SimpleDialogOption(
                child: new Text("新建咨询"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _gridItem(String bgImage, String icon, String text) {
    return Container(
        child: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
                image: DecorationImage(
                    image: AssetImage(bgImage), fit: BoxFit.fill),
              ),
              child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        loadAssetImage(icon,
                            color: Colors.white, height: 40, width: 40),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ))),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),

            child: Text('12',style: TextStyle(color: Colors.white),),
          ),
        ),
      ],
    ));
  }
}
