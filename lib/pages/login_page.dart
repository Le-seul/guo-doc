
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/user_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/sms_login_page.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/text_field.dart';
import 'package:keyboard_actions/keyboard_actions.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //定义一个controller
  TextEditingController _nameController;
  TextEditingController _passwordController;
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  String inputName = 'test_mj';
  String inputPassword = 'mj123456';


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
    _nameController = TextEditingController.fromValue(TextEditingValue(
      // 设置内容
        text: inputName,
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream,
            offset: inputName.length))));
    _passwordController = TextEditingController.fromValue(TextEditingValue(
      // 设置内容
        text: inputPassword,
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream,
            offset: inputPassword.length))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
          child: _buildBody(),
        ) : SingleChildScrollView(
          child: _buildBody(),
        )
    );
  }

  _buildBody(){
    return  Padding(
      padding: EdgeInsets.only(left: 16,right: 16,top: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: loadAssetImage('login/logo.png',
                  fit: BoxFit.cover, height: 150, width: 150),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "用户登录",style: TextStyle(fontSize: 20,color: Colors.black26),
            ),
            SizedBox(height: 46,),
            MyTextField(
              focusNode: _nodeText1,
              prefixIcon: 'login/mobile.png',
              controller:_nameController,
              maxLength: 18,
              hintText: "请输入身份证号",
            ),
            SizedBox(height: 30,),
            MyTextField(
              focusNode: _nodeText2,
              config: _buildConfig(context),
              prefixIcon: 'login/password.png',
              isInputPwd: true,
              controller: _passwordController,
              maxLength: 16,
              hintText: "请输入警号(民警输入)",
            ),
            SizedBox(height: 30,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff2CA687), borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                  onPressed: () {
                    _userAuthCheck();
                  },
                  child: Text(
                    '下一步',
                    style: TextStyle(color: Colors.white,fontSize: 20),
                  )),
            )
          ],
        ),

    );
  }
  _userAuthCheck(){
    var bytes1 = utf8.encode(_nameController.text);
    var bytes2 = utf8.encode(_passwordController.text);
    var identityNum = sha1.convert(bytes1);
    var policeNum = sha1.convert(bytes2);

    DioUtils.instance.requestNetwork<User>(
        Method.post,
        Api.USERAUTHCHECK,
        queryParameters: {
          'IDCardNumberSHA1Code':identityNum,
          'policemanIdSHA1Code':(_passwordController.text.isEmpty) ? null : policeNum,
        },
        onSuccess: (data) {
          setState(() async{
            await StorageManager.sharedPreferences.setString(Constant.userInfo, json.encode(data));
            NavigatorUtil.pushReplacementNamed(context,SMSLogin(user: data,));
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
          });
        }
    );
  }
}
