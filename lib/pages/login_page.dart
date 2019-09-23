
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/text_field.dart';
import 'package:keyboard_actions/keyboard_actions.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //定义一个controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();


  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("关闭"),
          ),
        ),
        KeyboardAction(
          focusNode: _nodeText2,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("关闭"),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
//    _nameController.text = FlutterStars.SpUtil.getString(Constant.phone);
  }

  void _verify(){
//    String identityNum = _nameController.text;
//    Toast.show(identityNum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
          child: _buildBody(),
        ) : SingleChildScrollView(
          child: _buildBody(),
        )
    );
  }

  _buildBody(){
    return  Padding(
      padding: EdgeInsets.only(left: 16,right: 16,top: 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "用户登录",style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16,),
            MyTextField(
              focusNode: _nodeText1,
              controller: _nameController,
              maxLength: 18,
              hintText: "请输入身份证号",
            ),
            SizedBox(height: 10,),
            MyTextField(
              focusNode: _nodeText2,
              config: _buildConfig(context),
              isInputPwd: true,
              controller: _passwordController,
              maxLength: 16,
              hintText: "请输入警号",
            ),
            SizedBox(height: 25,),
            FlatButton(
                onPressed: (){
                  _userAuthCheck();
                },
                color: Colors.blue,
                child: Text('下一步',style: TextStyle(color: Colors.white),))
          ],
        ),

    );
  }
  _userAuthCheck(){

    var bytes1 = utf8.encode(_nameController.text); // data being hashed
    var bytes2 = utf8.encode(_passwordController.text);
    var identityNum = sha1.convert(bytes1);
    var policeNum = sha1.convert(bytes2);
    Toast.show('加密身份证号：$identityNum\n加密警号：$policeNum');

    DioUtils.instance.requestNetwork<String>(
        Method.post,
        Api.USERAUTHCHECK,
        queryParameters: {
          'IDCardNumberSHA1Code':identityNum,
          'policemanIdSHA1Code':policeNum,
        },
        onSuccess: (data) {
          setState(() {
            Toast.show(data.toString());
            Router.pushNoParams(context, Router.smsLogin);
          });
        },
        onError: (code, msg) {
          setState(() {
            Toast.show('账号验证失败!');
          });
        },
        noExistError: (){
          setState(() {
            Toast.show('用户不存在!');
            Router.pushNoParams(context, Router.smsLogin);
          });
        }
    );
  }

}
