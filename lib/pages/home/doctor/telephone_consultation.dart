import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/bean/all_order_entity.dart';
import 'package:flutter_first/bean/fastphone_info.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/serviceLocator.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/tel_service.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/my_card.dart';

class TelConsultation extends StatefulWidget {
  @override
  _TelConsultationState createState() => _TelConsultationState();
}

class _TelConsultationState extends State<TelConsultation>
    implements OnDialogClickListener {
  String selectText = '';

  String clinicNo = '';
  final TelAndSmsService _service = locator<TelAndSmsService>();
  final String number = "65260001";
  bool offstage = true;
  String phone = '';
  List<FastphoneInfo> fastphoneInfoList = List();

  @override
  void initState() {
    phone = StorageManager.sharedPreferences.getString(Constant.phone);
    _getFastPhoneInfo();
  }

  _getFastPhoneInfo() {
    print("获取科室信息！");
    DioUtils.instance.requestNetwork<FastphoneInfo>(
        Method.get, Api.GETFASTPHONEINFO,
        isList: true, onSuccessList: (data) {
      fastphoneInfoList = data;
      print("获取科室信息成功！");
    }, onError: (code, msg) {
      print("获取科室信息失败！");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          '快捷电话',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black12,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Image.asset(
              'assets/images/tel_consutation.png',
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: MyCard(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Offstage(
                        offstage: offstage,
                        child: Text(
                          selectText == "心理咨询"
                              ? '服务时间：19:00-21:00'
                              : '服务时间：9:00-21:00',
                          style: TextStyle(color: Colors.black26),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Text('选择科室'),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: GestureDetector(
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.only(left: 15),
                              color: Colors.black12,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(selectText),
                                  Icon(
                                    Icons.arrow_right,
                                    color: Colors.black26,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false, //BuildContext对象
                                  builder: (BuildContext context) {
                                    return SelectDialog(this);
                                  });
                            },
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Text('接听手机'),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 15),
                              color: Colors.black12,
                              height: 40,
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                  controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                          text: phone == null
                                              ? ''
                                              : '$phone', //判断keyword是否为空
                                          // 保持光标在最后

                                          selection: TextSelection.fromPosition(
                                              TextPosition(
                                                  affinity:
                                                      TextAffinity.downstream,
                                                  offset: '${phone}'.length)))),
                                  onChanged: (val) {
                                    phone = val;
                                  },
                                  cursorColor: Colors.black,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter
                                        .digitsOnly, //只输入数字
                                    LengthLimitingTextInputFormatter(11) //限制长度
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0.0),
                                    border: InputBorder.none,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: MyCard(
                  child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '服务说明',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        """（1）选择科室：需实现的技术：心理咨询-工作日19:00-21:00可拨号65260001 非工作时间咨询可提示一下时间。
 （2）接听手机：可直接是用户注册电话.
 （3）服务说明：提交成功后，医生会尽快联系您；非服务时间，医生会在次日联系您，请您保持电话畅通。
 各科咨询时间为10分钟，心理咨询可在工作日19:00-21:00拨打电话65260001.
 如有疑问，请联系客服400-001-8855.""",textScaleFactor: 1.1,strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5),),
                  ],
                ),
              )),
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        child: Container(
          height: 45,
          alignment: Alignment.center,
          color: Color(0xff2CA687),
          child: Text(
            '立即提交',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        onTap: () {
          _createFastphoneOrder();
        },
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  @override
  void onCancel() {
    // TODO: implement onCancel
  }

  @override
  void onOk(str) {
    setState(() {
      clinicNo = "";
      for (FastphoneInfo fastphoneInfo in fastphoneInfoList) {
        print("$str:${fastphoneInfo.clinicName}");
        if (str == fastphoneInfo.clinicName) {
          clinicNo = fastphoneInfo.clinicNo;
          print(clinicNo);
        }
      }
      if (str == '心理咨询') {
        _service.call(number);
      }
      offstage = false;
      selectText = str;
    });
  }

  _createFastphoneOrder() {
    if (selectText == "") {
      Toast.show('请选择科室');
    } else if (phone == "") {
      Toast.show('请输入电话');
    } else if (clinicNo == "") {
      Toast.show('该科室未开通电话问诊');
    } else {
      DioUtils.instance.requestNetwork<String>(
          Method.post, Api.CREATEFASTPHONEORDER,
          queryParameters: {"clinicNo": clinicNo, "phone": phone},
          onSuccess: (data) {
        Router.pushReplacementNamed(context, Router.historyRecord,null);
//            Toast.show('clinicNo:$clinicNo,phone:$phone');
      }, onError: (code, msg) {
        Toast.show('上传失败！');
      });
    }
  }
}

//定义一个抽象类
abstract class OnDialogClickListener {
  void onOk(String str);

  void onCancel();
}

class SelectDialog extends Dialog {
  final OnDialogClickListener callback;

  SelectDialog(this.callback);

  var items = ['儿科', '妇科', '皮肤科', '男科', '产科', '心理咨询', '呼吸内科', '消化内科', '泌尿内科'];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        //创建透明层
        type: MaterialType.transparency, //透明类型
        child: Center(
          //保证控件居中效果
          child: Container(
            height: 220,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: new Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Text('选择科室'),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: GridView.count(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8.0),
                    primary: false,
                    mainAxisSpacing: 12.0, // 竖向间距
                    crossAxisCount: 3, // 横向 Item 的个数
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 2.0, // 横向间距
                    children: buildGridTileList(context),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  List<Widget> buildGridTileList(BuildContext context) {
    List<Widget> widgetList = new List();
    for (int i = 0; i < items.length; i++) {
      widgetList.add(
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            color: Colors.black12,
            child: Text(items[i]),
          ),
          onTap: () {
            callback.onOk(items[i]);
            Navigator.of(context).pop();
          },
        ),
      );
    }
    return widgetList;
  }
}
