import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/chunyu_message.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:flutter_first/bean/order_count.dart';
import 'package:flutter_first/bloc/bloc_provider.dart';
import 'package:flutter_first/bloc/chunyu_bloc.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/db/order_db.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/doctor/graphic_consuitation.dart';
import 'package:flutter_first/pages/home/doctor/history_record.dart';
import 'package:flutter_first/pages/home/doctor/telephone_consultation.dart';
import 'package:flutter_first/util/dialog.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/real_rich_text.dart';
import 'package:flutter_first/widgets/top_panel.dart';

class DoctorChunyuHomePage extends StatefulWidget {
  @override
  _DoctorChunyuHomePageState createState() => _DoctorChunyuHomePageState();
}

class _DoctorChunyuHomePageState extends State<DoctorChunyuHomePage> {
  int orderCount = 0;
  String tuWenNum = '';
  String fastPhone = '';
  var db = OrderDb();
  String title = '在线问诊栏目有关服务条款及隐私政策需求';
  String content ='''
“在线问诊”服务充分尊重并保护用户个人隐私权，我们将以高度审慎的态度对待您的信息。为便于您使用该项服务，请您在使用服务前，仔细阅读并充分理解以下条款。

1.在进行在线问诊时，为您提供咨询的医生是由“春雨医生”系统根据医疗咨询病情，智能推荐的有丰富咨询经验的专业医生。

2. 为正常完成图文问诊服务功能，您需提供自身症状、疾病和身体状况的描述。医生将根据您提供的信息进行咨询服务。为您服务的医生仅了解您自主提供的信息，不会知晓您的姓名、联系方式、工作单位等个人信息，也不会知晓您在本APP和《民警健康管理系统》中任何与您相关的健康档案信息。

3.您在“电话问诊”中留下的电话号码，仅会提供给“春雨医生”系统。为您提供电话咨询的医生，不会知晓您的电话号码，同样，也不会知晓您的个人信息和健康档案信息。

4.在问诊过程中，为了更好的帮助到您，医生可能需要您提供性别、年龄、诊断证明、检查单、CT、磁核共振（MRI）的图片等信息，您可自主选择提供或不提供，均由您自己决定。同时，我们不建议您在问诊过程中，透露与医疗咨询无关的您的姓名、工作单位、联系方式等个人信息。

5.医生对于您所咨询病情的回复、提出的诊断或者医嘱，均基于您提供的信息和医生个人专业判断，仅供参考。如遇急重症病情不适合网上咨询，请立即前往医院就诊。

6.如果您需要帮他人咨询医疗问题，请参照本文第2款 至第6款内容，将患者有关信息提供给医生开展问诊。

7.所有上述基于“春雨医生”系统的服务，您的所有信息均为匿名信息，“春雨医生”平台不会知晓您没有主动提供的个人信息和健康档案信息，对于匿名的问诊内容“春雨医生”也会严格保密。

8.本APP以及《民警健康管理系统》对您的问诊记录将会严格保密，我们保证不对外公开或向任何第三方提供您的问诊信息。对于您的在线问诊史（包括问诊文字和图片），您可自主选择删除或保留（删除后，您自己也将无法再次查看问诊信息）；对于您已经删除的问诊史，我们保证不在系统中留存任何备份。

9.隐私是每个人的权利。我们会严格遵守本文规定，并通过技术手段，确保您个人信息的安全。''';

  @override
  void initState() {
    init();
  }



  init() async {

    List<Map> list = await db.getAllOrder();
//    print("数据库list3:$list");
    List<OrderNum> listNum = List();
    for (Map map in list) {
      listNum.add(OrderNum.fromJson(map));
    }
    int intTuWen = 0;
    int intFastPhone = 0;
    for (OrderNum orderNum in listNum) {
      setState(() {
        if (orderNum.location == "chunyuTuwen") {
          intTuWen = int.parse(orderNum.num) + intTuWen;
          tuWenNum = "$intTuWen";
//          print("tuWenNum2:$tuWenNum");
        } else {
          intFastPhone = int.parse(orderNum.num) + intFastPhone;
          fastPhone = "$intFastPhone";
        }
      });
    }
    bool isAree = StorageManager.sharedPreferences.getBool(Constant.onlinIsAgree);
    if(isAree == null||isAree == false){
      ShowClauseDialog.showMyMaterialDialog(context,title,content,'online');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChunyuPushBloc bloc = BlocProvider.of<ChunyuPushBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                LoginTopPanel(),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: Text(
                        '在线问诊',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
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
                            padding: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 20.0,
                                bottom: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '服务说明',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RealRichText(
                                  [
                                    TextSpan(
                                      text: "欢迎您使用在线医生进行医疗咨询，该栏目是由",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          height: 1.5),
                                    ),
                                    TextSpan(
                                      text: "北京市春雨医生软件有限公司",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          height: 1.5),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          NavigatorUtil.pushWebView(
                                              context,
                                              'https://www.chunyuyisheng.com/',
                                              {'title': '在线问诊'});
                                        },
                                    ),
                                    TextSpan(
                                      text: "提供支持。咨询医生均为全国三甲医院医生组成。",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          height: 1.5),
                                    ),
                                  ],
                                  textScaleFactor: 1.1,
                                ),
                                RealRichText(
                                  [
                                    TextSpan(
                                      text: "《图文问诊》 ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 1.5),
                                    ),
                                    TextSpan(
                                      text:
                                          "服务时间为7*24小时，医生将在6分钟内为您解答（夜间30分钟内）；",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          height: 1.5),
                                    ),
                                  ],
                                  textScaleFactor: 1.1,
                                ),
                                RealRichText(
                                  [
                                    TextSpan(
                                      text: "《快捷问诊》",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 1.5),
                                    ),
                                    TextSpan(
                                      text:
                                          "服务时间为每日早9：00——晚7：00，医生将在10分钟内向您回电。",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          height: 1.5),
                                    ),
                                  ],
                                  textScaleFactor: 1.1,
                                ),
                                RealRichText(
                                  [
                                    TextSpan(
                                      text: "如遇急重症病情，不适合网上咨询，请立即前往医院就诊。",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 1.5),
                                    ),
                                  ],
                                  textScaleFactor: 1.1,
                                ),
                              ],
                            ),
                          )),
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 4,
                    height: 15,
                    color: Color(0xff2CA687),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '问诊服务',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<ChunyuMessage>(
              stream: bloc.stream,
              builder: (BuildContext context,
                  AsyncSnapshot<ChunyuMessage> snapshot) {
                  return Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          child: _gridItem(
                              Colors.blue,
                              'assets/images/service/图.png',
                              '图文问诊',
                              '通过聊天方式解决您的问题',
                              snapshot.hasData?"${snapshot.data.tuwenNum}":tuWenNum,
                              snapshot.hasData?snapshot.data.tuwenNum == 0:tuWenNum == '0'||tuWenNum == ''),
                          onTap: () {
                            getOrderCount();
                            NavigatorUtil.pushPage(
                                context, GraphicConsultation());
                          },
                        ),
                        GestureDetector(
                          child: _gridItem(
                              Colors.orange,
                              'assets/images/service/电话.png',
                              '电话问诊',
                              '通过电话解决您的问题',
                              snapshot.hasData?"${snapshot.data.fastPhoneNum}":fastPhone,
                              snapshot.hasData?snapshot.data.fastPhoneNum == 0:fastPhone == '0'||fastPhone == ''),
                          onTap: () {
                            NavigatorUtil.pushPage(context, TelConsultation());
                          },
                        ),
                        GestureDetector(
                          child: _gridItem(
                              Colors.green,
                              'assets/images/service/钟.png',
                              '历史记录',
                              '您之前问过的问题都在这里',
                              '',
                              true),
                          onTap: () {
                            NavigatorUtil.pushPage(context, HistoryRecord());
                          },
                        )
                      ],
                    ),
                  );
              },
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '我们将全力保护您的隐私',
                  style: TextStyle(color: Colors.black26, fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('严格遵守',
                        style: TextStyle(color: Colors.black26, fontSize: 12)),
                    GestureDetector(
                        onTap: () {
                          NavigatorUtil.pushWebView(
                              context,
                              'http://49.232.168.124/phms_resource_base/HomePageDetail/onlinePrivacyPolicy.htm',
                              {'title': '服务条款及隐私政策'});
                        },
                        child: Text(
                          '服务条款及隐私政策',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  getOrderCount() {
    DioUtils.instance.requestNetwork<OrderCount>(Method.get, Api.ORDERCOUNT,
        onSuccess: (data) {
      setState(() {
        orderCount = data.count;
        if (orderCount != 0) {
          showDialog<Null>(
              context: context, //BuildContext对象
              barrierDismissible: false,
              builder: (BuildContext context) {
                return ConsutationDialog();
              });
        }

//        showMySimpleDialog(context);
        print('获取数量成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        print('获取数量失败!');
      });
    });
  }

  void showMySimpleDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new SimpleDialog(
            title: new Text("咨询问题"),
            children: <Widget>[
              new SimpleDialogOption(
                child: new Text("正在咨询$orderCount"),
                onPressed: () {
                  Navigator.of(context).pop();
                  NavigatorUtil.pushPage(context, HistoryRecord());
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

  _gridItem(Color color, String icon, String text, String txt, String count,
      offstage) {
    return Container(
        padding: EdgeInsets.all(10),
        child: MyCard(
            child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                icon,
                height: 55,
                width: 55,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 90,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              text,
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF4E4E4E)),
                            ),
                          ),
                          Offstage(
                            offstage: offstage,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: EdgeInsets.only(left: 6, right: 6),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  count,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      txt,
                      style: TextStyle(color: Colors.black26, fontSize: 12),
                    )
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.black54,
              )
            ],
          ),
        )));
  }
}
