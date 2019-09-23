import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SMSLogin extends StatefulWidget {
  @override
  _SMSLoginState createState() => _SMSLoginState();
}

class _SMSLoginState extends State<SMSLogin> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  Token tokenData;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_verify);
    _vCodeController.addListener(_verify);
  }

  void _verify() {
    String name = _phoneController.text;
    String vCode = _vCodeController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 120.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "手机号验证",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: _phoneController,
              maxLength: 11,
              keyboardType: TextInputType.phone,
              hintText: "请输入手机号",
            ),
            SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: _vCodeController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              hintText: "请输入验证码",
              getVCode: () {
                _sendVerificationCode();
              },
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 25,
            ),
            FlatButton(
                onPressed: () {
                  _checkVerificationCode();
                },
                color: Colors.blue,
                child: Text(
                  '登录',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }

  _sendVerificationCode() {
    DioUtils.instance
        .requestNetwork<String>(Method.post, Api.SENDVCODE, queryParameters: {
      'userId': "1",
      'phonrNumberBODY': _phoneController.text,
    }, onSuccess: (data) {
      setState(() {
        Toast.show('获取验证码成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show('获取验证码失败!');
      });
    }, mismatchingError: () {
      setState(() {
        Toast.show('手机号不匹配!');
      });
    });
  }

  static saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constant.access_Token,token);
  }

  _checkVerificationCode() async {
    DioUtils.instance
        .requestNetwork<Token>(Method.get, Api.CHECKVCODE, queryParameters: {
      'userId': "1",
      'verificationCode': _vCodeController.text,
    }, onSuccess: (data) {
      setState(() {
        Toast.show('验证成功!');
        tokenData = data;
        Toast.show(tokenData.token.toString());
        Dio dio = DioUtils.instance.getDio();
        dio.lock();
        saveToken(tokenData.token);
        dio.unlock();
        Router.pushNoParams(context, Router.containerPage);
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show('验证失败!');
      });
    }, noExistError: () {
      setState(() {
        Toast.show('验证码不存在!');
      });
    }, mismatchingError: () {
      setState(() {
        Toast.show('验证码不匹配!');
      });
    }, expiredError: () {
      setState(() {
        Toast.show('验证码过期!');
      });
    });
  }
}
