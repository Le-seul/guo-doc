import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_center_model.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/toast.dart';

class InitiateConsultationPage extends StatefulWidget {
  String relation;
  String type;
  String name;
  String gender;
  String birthday;
  @override
  _InitiateConsultationPageState createState() =>
      _InitiateConsultationPageState();

  InitiateConsultationPage(this.type,{this.relation, this.name, this.birthday, this.gender});
}

class _InitiateConsultationPageState extends State<InitiateConsultationPage> {
  var value;
  int selectValue = -1;
  String emergePerson;
  String emergePhone;
  String consultContent;
  List<SeviceLocation> serviceCenterList = List();

  @override
  void initState() {
    _getServiceCenterList();
  }

  _getServiceCenterList() {
    DioUtils.instance.requestNetwork<SeviceLocation>(
      Method.get,
      Api.GETSERVICECENTERLIST,
      isList: true,
      onSuccessList: (data) {
        setState(() {
          serviceCenterList = data;
        });
      },
      onError: (code, msg) {
        setState(() {

        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          '心理咨询',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 45.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('紧急联络人：'),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 25,
                    child: TextField(
                        onChanged: (val) {
                          emergePerson = val;
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          border: InputBorder.none,
                        )),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('紧急联络人联系电话：'),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 25,
                      child: TextField(
                          onChanged: (val) {
                            emergePhone = val;
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            border: InputBorder.none,
                          )),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                    ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                '咨询内容：',
                style: TextStyle(fontSize: 17),
              ),
              padding: EdgeInsets.only(left: 5, bottom: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CheckboxDefault(this, 0, '人际关系'),
                CheckboxDefault(this, 1, '婚姻爱恋'),
                CheckboxDefault(this, 2, '家庭关系'),
                CheckboxDefault(this, 3, '亲密关系'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CheckboxDefault(this, 4, '亲自教育'),
                CheckboxDefault(this, 5, '情绪压力'),
                CheckboxDefault(this, 6, '行为问题'),
                CheckboxDefault(this, 7, '学业职场'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CheckboxDefault(this, 8, '个人职场'),
                CheckboxDefault(this, 9, '性心理  '),
              ],
            ),
            Container(
              height: 150,
              padding: EdgeInsets.only(bottom: 5),
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: TextField(
                  onChanged: (val) {
                    consultContent = val;
                  },
                  maxLines: 20,
                  maxLength: 300,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: '请简要描述需要咨询的内容，以及期待达到的咨询效果。',
                    counterText: '0/300字',
                    counterStyle: TextStyle(color: Colors.black, fontSize: 12),
                    contentPadding: EdgeInsets.all(5.0),
                    border: InputBorder.none,
                  )),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                '优选时间：',
                style: TextStyle(fontSize: 17),
              ),
              padding: EdgeInsets.only(left: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text('工作日'),
              padding: EdgeInsets.only(left: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CheckboxSelect(context.widget, this, 0, '09:00-12:00'),
                SizedBox(
                  width: 60,
                ),
                CheckboxSelect(context.widget, this, 1, '12:00-14:00'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CheckboxSelect(context.widget, this, 2, '14:00-18:00'),
                SizedBox(
                  width: 60,
                ),
                CheckboxSelect(context.widget, this, 3, '18:00-21:00'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text('周末'),
              padding: EdgeInsets.only(left: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CheckboxSelect(context.widget, this, 4, '09:00-12:00'),
                SizedBox(
                  width: 60,
                ),
                CheckboxSelect(context.widget, this, 5, '12:00-14:00'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CheckboxSelect(context.widget, this, 6, '14:00-18:00'),
                SizedBox(
                  width: 60,
                ),
                CheckboxSelect(context.widget, this, 7, '18:00-21:00'),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text('地点：'),
                  padding: EdgeInsets.only(left: 20),
                ),
                SizedBox(width: 40,),
                Center(
                  child: Container(
                      height: 30,
                      child: DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          items: getListData(),
                          hint: new Text("808心理服务分中心"), //当没有默认值的时候可以设置的提示
                          value: value, //下拉菜单选择完之后显示给用户的值
                          onChanged: (T) {
                            //下拉菜单item点击之后的回调
                            setState(() {
                              value = T;
                            });
                          },
                          style: new TextStyle(
                            //设置文本框里面文字的样式
                              color: Colors.black),
                          //              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                          iconSize: 20.0, //设置三角标icon的大小
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                      )
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: Text('详情',style: TextStyle(color: Colors.blue),),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Center(child: value == null?Text('地址：808心理服务分中心'):
            Text('地址：${serviceCenterList[int.parse(value)-1].location}',style: TextStyle(fontSize: 12),),),
            SizedBox(height: 20,)
          ]
        ),
      ),
      bottomSheet: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 45,
          color: Colors.blue,
          child: GestureDetector(
            child: Text(
              '提交',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              if(emergePerson == ""||emergePerson == null){
                Toast.show('请输入紧急联络人!');
              }else if(emergePhone == ""|| emergePhone == null){
                Toast.show('请输入紧急联络人联系电话!');
              }else if(category == ""|| category == null){
                Toast.show('请选择咨询内容!');
              }else if(expectStartTime == ""|| expectStartTime == null){
                Toast.show('请选择咨询时间!');
              }else if(value == ""|| value == null){
                Toast.show('请选择咨询地点!');
              }else if(!checkMobile(emergePhone)){
                Toast.show('请输入正确手机号!');
              }else{
                _postInfometion();
              }
            },
          )),
      resizeToAvoidBottomPadding: false,
    );
  }

   bool checkMobile(var sMobile){
     RegExp exp = RegExp(
         r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
     bool matched = exp.hasMatch(sMobile);
     return matched;
  }



  _postInfometion(){

    DioUtils.instance.requestNetwork<String>(
      Method.post,
      Api.GREATEORDER,
      queryParameters: {
        'type':widget.type,
        'name':widget.type == 'SELF'? null : widget.name,
        'gender':widget.type == 'SELF'? null : widget.gender,
        'birthday':widget.type == 'SELF'? null : widget.birthday,
        'emergePerson':emergePerson,
        'emergePhone':emergePhone,
        'relation':widget.type == 'SELF' ? 'SELF': widget.relation,
        'category':category,
        'consultContent':consultContent,
        'expectTime':date,
        'expectStartTime':expectStartTime,
        'expectEndTime':expectEndTime,
        'expectLocation':value,
      },
      onSuccess: (data) {
        setState(() {
          Toast.show('提交成功!');
        });
      },
      onError: (code, msg) {
        setState(() {
          Toast.show('提交失败!');
        });
      },
      onParseError: (){
        setState(() {
          Toast.show('已提交，勿重复提交!');
        });

      }
    );
  }


  @override
  void dispose() {
    list = List();
  }

  List<DropdownMenuItem> getListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem;
    for (int i = 0; i <serviceCenterList.length; i++) {
      dropdownMenuItem = new DropdownMenuItem(
        child: new Text(serviceCenterList[i].name),
        value: serviceCenterList[i].id,
      );
      items.add(dropdownMenuItem);
    }
    return items;
  }
}
String expectLocation;
String date = 'G';
String expectStartTime;
String expectEndTime;
String category;
List<String> list = List();

class CheckboxDefault extends StatefulWidget {
  final int index;
  final parent;
  String text;
  CheckboxDefault([this.parent, this.index = -1, this.text]) : super();
  @override
  State<StatefulWidget> createState() => _CheckboxDefault(text);
}

class _CheckboxDefault extends State {
  bool isChecked = false;
  Color color = _randomColor(); // 注意和下面的 StatelessWidget 里的 _randomColor 区别
  String text;
  _CheckboxDefault(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              child: Checkbox(
                  activeColor: color,
                  tristate: false,
                  value: isChecked,
                  onChanged: (bool bol) {
                    if (mounted) {
                      setState(() {
                        isChecked = bol;
                        if (isChecked == true) {
                          list.add(text);
                        } else {
                          list.remove(text);
                        }
                        category = list.toString().replaceAll('[', '').replaceAll(']', '');
                        Toast.show(category);
                      });
                    }
                  }),
            ),
            SizedBox(
              width: 5,
            ),
            Text(text),
          ],
        ));
  }
}
class CheckboxSelect extends StatelessWidget {
  final int index;
  final widget;
  final parent;
  final String text;

  const CheckboxSelect([this.widget, this.parent, this.index = -1, this.text])
      : super();

  @override
  Widget build(BuildContext context) {
    Color color = _randomColor();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 12,
            height: 12,
            child: Checkbox(
                activeColor: color,
                tristate: false,
                value: parent.selectValue == this.index,
                onChanged: (bool bol) {
                  if (parent.mounted) {
                    parent.setState(() {
                      parent.selectValue = bol ? this.index : -1;
                      if (this.index >= 0 && this.index <= 3){
                        date = 'G';
                      }else if (this.index >= 4 && this.index <= 7){
                        date = 'Z';
                      }
                      expectStartTime = text.split('-')[0].replaceAll(':', '');
                      expectEndTime = text.split('-')[1].replaceAll(':', '');
                      Toast.show(date+'  '+expectStartTime+'  '+expectEndTime);
                    });
                  }
                })),
        SizedBox(
          width: 5,
        ),
        Text(text),
      ],
    );
  }
}

Color _randomColor() {
  var red = Random.secure().nextInt(255);
  var greed = Random.secure().nextInt(255);
  var blue = Random.secure().nextInt(255);
  return Color.fromARGB(255, red, greed, blue);
}
