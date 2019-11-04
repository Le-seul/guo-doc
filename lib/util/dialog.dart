import 'package:extended_image/extended_image.dart';
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
class ConsutationDialog extends Dialog {

  @override
  Widget build(BuildContext context) {
    return new Material( //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center( //保证控件居中效果
        child:Container(
          padding: EdgeInsets.all(20),
          height: 120,
          width: 280,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12)),
          child: new Column(
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Text('请选择',style: TextStyle(fontSize: 20),),
                GestureDetector(child: Icon(Icons.close,size: 25,),onTap: (){
                  Navigator.of(context).pop();
                },)
              ],),
              SizedBox(height: 20,),
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: Container(

                      decoration: BoxDecoration(
                          color: Color(0xff2CA687),
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),

                      child: Text('继续已有问诊',style: TextStyle(color: Colors.white,fontSize: 15),),
                    ),
                    onTap: (){
                      Router.pushNoParams(context, Router.historyRecord);
                    },
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    child: Container(

                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      child: Text('创建新的问诊',style: TextStyle(color: Colors.white,fontSize: 15),),
                    ),
                    onTap: (){
                      Navigator.of(context).pop();
                    },

                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
class ShowbigImage extends Dialog {
  String imageUrl;
  ShowbigImage(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material( //创建透明层
        type: MaterialType.transparency, //透明类型
        child: ExtendedImage.network(
          imageUrl,
          fit: BoxFit.contain,
          //enableLoadState: false,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: (state) {
            return GestureConfig(
                minScale: 0.9,
                animationMinScale: 0.7,
                maxScale: 3.0,
                animationMaxScale: 3.5,
                speed: 1.0,
                inertialSpeed: 100.0,
                initialScale: 1.0,
                inPageView: false);
          },
        )
      ),
      onTap: (){
        Navigator.of(context).pop();
      },
    );
  }


}