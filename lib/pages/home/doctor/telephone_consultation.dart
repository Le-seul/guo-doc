import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/common/common.dart';
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
  final TelAndSmsService _service = locator<TelAndSmsService>();
  final String number = "123456789";
  bool offstage = true;
  String phone;

  @override
  void initState() {
    phone = StorageManager.sharedPreferences.getString(Constant.phone);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          selectText == "心理科"?'服务时间：10:00-18:00':'服务时间：9:00-21:00',
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
                                          text:
                                              '${phone == null ? "" : phone}')),
                                  onChanged: (val) {},
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
          Toast.show('提交成功!');
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
      if(str == '心理科'){
        _service.call(number);
      }
      offstage = false;
      selectText = str;
    });
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

  var items = ['儿科', '妇科', '皮肤科', '男科', '产科', '心理科', '呼吸内科', '消化内科', '泌尿内科'];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child:  Center(
          //保证控件居中效果
          child: Container(
            color: Colors.white,
            height: 220,
            width: 300,
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
      onTap: (){
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
