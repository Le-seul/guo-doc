import 'package:flutter/material.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/datetime_picer/datetime_picker_theme.dart';
import 'package:flutter_first/util/datetime_picer/flutter_datetime_picker.dart';
import 'package:flutter_first/util/datetime_picer/i18n_model.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';

class RelativesInformationPage extends StatefulWidget {
  @override
  _RelativesInformationPageState createState() =>
      _RelativesInformationPageState();
}

class _RelativesInformationPageState extends State<RelativesInformationPage> {
  String name;
  String birthday = '';
   int groupValue1 = 0;
  String gender ;
  String relation;
  genderChange(val) {
    this.setState(() {
      groupValue1 = val;
      if(groupValue1==0){
        gender = 'M';
      }else if (groupValue1 == 1){
        gender = 'F';
      }
    });
  }

  int groupValue = 1;
  onChange(val) {
    this.setState(() {
      groupValue = val;
      if(groupValue == 1){
        relation = 'CHIL';
      }else if(groupValue == 2){
        relation = 'PARE';
      }else if(groupValue == 3){
        relation = 'SPOU';
      }
    });
  }
  RadioItem(int value, String text) {
    return Row(
      children: <Widget>[
        Radio(
            value: value,
            groupValue: groupValue, //当value和groupValue一致的时候则选中
            onChanged: (T) {
              onChange(T);
            }),
        Text(text),
      ],
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
          '亲属资料填写',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black12,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '与本人关系：',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  RadioItem(1, '子女'),
                  RadioItem(2, '父母'),
                  RadioItem(3, '配偶'),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text('姓名：'),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 25,
                          width: 200,
                          child: TextField(
                              onChanged: (val) {
                                name = val;
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
                  Container(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text('性别：'),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Radio(
                                  value: 0,
                                  groupValue:
                                      groupValue1, //当value和groupValue一致的时候则选中
                                  onChanged: (T) {
                                    genderChange(T);
                                  }),
                              Text('男'),
                              Radio(
                                  value: 1,
                                  groupValue:
                                      groupValue1, //当value和groupValue一致的时候则选中
                                  onChanged: (T) {
                                    genderChange(T);
                                  }),
                              Text('女')
                            ],
                          ),
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text('出生年份：'),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 25,
                            width: 200,
                            child: GestureDetector(
                              child: Text(
                                 birthday.split(' ')[0],
                              ),
                              onTap:() {
                                DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1949, 10, 1),
                                  maxTime: DateTime.now(),
                                  theme: DatePickerTheme(),
                                  onChanged: (date) {
                                    setState(() {
                                      birthday = date.toString();
                                    });
                                  },
                                  onConfirm: (date) {},
                                  currentTime: DateTime.now(),
                                );
                              },
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                          ),
                          flex: 3,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 45,
          color: Colors.blue,
          child: GestureDetector(
            child: Text(
              '下一步',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {

              if (name == '' || name == null) {
                Toast.show('请输入姓名!');
              } else if (birthday == '' || birthday == null) {
                Toast.show('请输入生日!');
              } else {
                Router.push(context, Router.initiateConsultationPage, {
                  'name': name,
                  'relation': relation,
                  'gender': gender,
                  'birthday': birthday
                });
              }
            },
          )),
      resizeToAvoidBottomPadding: false,
    );


  }
}
