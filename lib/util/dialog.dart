import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/service/servicenext/initiateconsultation_page.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';

class MyDialog {
  static void showMyMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Container(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Text(
                "提示",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.orange,
            ),
            contentPadding: EdgeInsets.only(left: 24, top: 24, bottom: 80),
            titlePadding: EdgeInsets.all(0.0),
            content: Text("与本人的关系"),
            actions: <Widget>[
              Container(
                width: 125,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            InitiateConsultationPage('SELF')));
                  },
                  child: new Text(
                    "本人",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.lightBlueAccent,
                ),
              ),
              Container(
                width: 125,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Router.pushNoParams(
                        context, Router.relativesInformationPage);
                  },
                  child: new Text(
                    "家属",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                ),
              ),

            ],
          );
        });
  }
}

class LoadingDialog extends Dialog {
  String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material( //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center( //保证控件居中效果
        child:Container(
            color: Colors.transparent,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 250.0,
                  height: 260.0,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18.0),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      loadAssetImage('successful_registration.png',height: 110,width: 110),
                      new Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: new Text(
                          '报名成功!',
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    color: Colors.transparent,
                    child: loadAssetImage('close.png',height: 35,width: 35 ),
                  ),
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
    );
  }
}