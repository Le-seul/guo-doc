import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/pages/home/doctor/history_record.dart';
import 'package:flutter_first/pages/service/servicenext/activity_participation.dart';
import 'package:flutter_first/pages/service/servicenext/initiateconsultation_page.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/util/storage_manager.dart';

//class MyDialog {
//  static void showMyMaterialDialog(BuildContext context) {
//    showDialog(
//        context: context,
//        builder: (context) {
//          return new AlertDialog(
//            title: new Container(
//              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
//              child: Text(
//                "提示",
//                style: TextStyle(color: Colors.white),
//              ),
//              color: Colors.orange,
//            ),
//            contentPadding: EdgeInsets.only(left: 24, top: 24, bottom: 80),
//            titlePadding: EdgeInsets.all(0.0),
//            content: Text("与本人的关系"),
//            actions: <Widget>[
//              Container(
//                width: 125,
//                child: FlatButton(
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                    Navigator.push(context, MaterialPageRoute(
//                        builder: (context) =>
//                            InitiateConsultationPage('SELF')));
//                  },
//                  child: new Text(
//                    "本人",
//                    style: TextStyle(color: Colors.white),
//                  ),
//                  color: Colors.lightBlueAccent,
//                ),
//              ),
//              Container(
//                width: 125,
//                child: FlatButton(
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                    Router.pushNoParams(
//                        context, Router.relativesInformationPage);
//                  },
//                  child: new Text(
//                    "家属",
//                    style: TextStyle(color: Colors.white),
//                  ),
//                  color: Colors.red,
//                ),
//              ),
//
//            ],
//          );
//        });
//  }
//}

class LoadingDialog extends Dialog {
  String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center(
        //保证控件居中效果
        child: Container(
          color: Colors.transparent,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 180.0,
                height: 180.0,
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
                    loadAssetImage('successful_registration.png',
                        height: 80, width: 80),
                    new Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: new Text(
                        '报名成功!',
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  color: Colors.transparent,
                  child: loadAssetImage('close.png', height: 35, width: 35),
                ),
                onTap: () {
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
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center(
        //保证控件居中效果
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          margin: EdgeInsets.only(left: 30, right: 30),
          height: 120,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: new Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('请选择'),
                    GestureDetector(
                      child: Icon(Icons.close, size: 20, color: Colors.black26),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff2CA687),
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          child: Text(
                            '继续已有问诊',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        onTap: () {
                          NavigatorUtil.pushReplacementNamed(
                              context, HistoryRecord());
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          child: Text(
                            '创建新的问诊',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
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
      child: Material(
          //创建透明层
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
          )),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}

class ShowClauseDialog extends Dialog {
  static showMyMaterialDialog(BuildContext context) {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Material(
            //创建透明层
            type: MaterialType.transparency, //透明类型
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Center(
                            child: Text(
                          '在线问诊须知',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ))),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Text(
                            '''“在线问诊”服务充分尊重并保护用户个人隐私权，我们将以高度审慎的态度对待您的信息。为便于您使用该项服务，请您在使用服务前，仔细阅读并充分理解以下条款。
                          1.在进行在线问诊时，为您提供咨询的医生是由“春雨医生”系统根据医疗咨询病情，智能推荐的有丰富咨询经验的专业医生。
                          2. 为正常完成图文问诊服务功能，您需提供自身症状、疾病和身体状况的描述。医生将根据您提供的信息进行咨询服务。为您服务的医生仅了解您自主提供的信息，不会知晓您的姓名、联系方式、工作单位等个人信息，也不会知晓您在本APP和《民警健康管理系统》中任何与您相关的健康档案信息。
                          3.您在“电话问诊”中留下的电话号码，仅会提供给“春雨医生”系统。为您提供电话咨询的医生，不会知晓您的电话号码，同样，也不会知晓您的个人信息和健康档案信息。
                          4.您在“电话问诊”中如果选择了“心理咨询”，在服务时段内，系统将会为您拨打市局民警心理服务热线——(010)65260001，“市局民警心理服务中心”委托“北京心理卫生协会”派驻的专业心理咨询师将会接听您的心理咨询电话。同样，心理咨询师会按照《北京市公安局民警心理服务中心热线咨询工作守则》严格保护您的个人隐私。
                        5.在问诊过程中，为了更好的帮助到您，医生可能需要您提供性别、年龄、诊断证明、检查单、CT、磁核共振（MRI）的图片等信息，您可自主选择提供或不提供，均由您自己决定。同时，我们不建议您在问诊过程中，透露与医疗咨询无关的您的姓名、工作单位、联系方式等个人信息。

                            ''',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: Center(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text('取消')))),
                          Expanded(
                            child: Center(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    setAgree();
                                  },
                                  child: Text('同意')),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static setAgree() async {
    await StorageManager.sharedPreferences.setBool(Constant.isAgree, true);
  }
}

class ShowActivityTab extends Dialog {
  final OnPressMunu onPressMunu;
  List<String> listText;
  ShowActivityTab(this.listText, this.onPressMunu);

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      child: Center(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                child: Icon(Icons.close),
            ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.0),
                      itemCount: listText.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            onPressMunu.onPress(index);
                          },
                          child: Container(
                            color: Color(0xFFEEEEEE),
                            child: Center(
                                child: Text(
                              listText[index],
                              style: TextStyle(fontSize: 15),
                            )),
                          ),
                        );
                      }),
                ),
              ],
            )),
      ),
    );
  }
}

class ShowExitDialog extends Dialog {
  static showMyMaterialDialog(BuildContext context) {
    showDialog<Null>(
      context: context, // BuildContext对象
      barrierDismissible: false, // 屏蔽点击对话框外部自动关闭
      builder: (_) => WillPopScope(
        child: AlertDialog(
          content: Text(
            '账户登录信息已过期，请重新登录',
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  StorageManager.exite();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "/login", (Route<dynamic> route) => false);
                },
                child: Text('确认')),
          ],
        ),
        onWillPop: () async {
          return Future.value(false);
        },
      ),
    );
  }
}
