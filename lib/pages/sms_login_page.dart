import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/user_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/text_field.dart';
import 'package:rxdart/rxdart.dart';

class SMSLogin extends StatefulWidget {

  User user;
  SMSLogin({Key key, @required this.user}) : super(key: key);

  @override
  _SMSLoginState createState() => _SMSLoginState();
}

class _SMSLoginState extends State<SMSLogin> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  Token tokenData;
  bool _isClick = true;
  final int second = 30;
  StreamSubscription _subscription;
  /// 当前秒数
  int s;


  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
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
            _MyTextField(),
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

  _MyTextField(){
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextField(

          maxLength: 6,
          autofocus: false,
          controller: _vCodeController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              hintText:"请输入验证码",
              counterText: "",
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue,
                      width: 0.8
                  )
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(

                      width: 0.8
                  )
              )
          ),
        ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Container(
                  height: 26.0,
                  width: 85.0,
                  child: FlatButton(
                    onPressed: _isClick ?(){
                      _sendVerificationCode();

                    }: null,
                    padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
                    textColor: Colors.black,
                    color: Colors.white,
                    disabledTextColor: Colors.white,
                    disabledColor: Colors.black26,
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                        side: BorderSide(
                          color: !_isClick ? Colors.black : Colors.black,
                          width: 0.8,
                        )
                    ),
                    child: Text(
                      !_isClick?"（$s s）":"获取验证码"  ,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),


    )]);
  }

  _sendVerificationCode() {
    DioUtils.instance
        .requestNetwork<String>(Method.post, Api.SENDVCODE, queryParameters: {
      'userId': widget.user.userId,
      'phoneNumber': _phoneController.text,
    }, onSuccess: (data) {
      setState(() {
        setState(() {
          s = second;
          _isClick = false;
        });
        _subscription = Observable.periodic(Duration(seconds: 1), (i) => i).take(second).listen((i){
          setState(() {
            s = second - i - 1;
            _isClick = s < 1;
          });
        });
        Toast.show('获取验证码成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        _isClick = true;
        Toast.show('获取验证码失败!');
      });
    }, noExistError: () {
      setState(() {
        _isClick = true;
        Toast.show('手机号不匹配!');
      });
    });
  }

  static saveToken(String token) async {
    StorageManager.sharedPreferences.setString(Constant.access_Token,token);
  }

  _checkVerificationCode() async {
    DioUtils.instance
        .requestNetwork<Token>(Method.get, Api.CHECKVCODE, queryParameters: {
      'userId': widget.user.userId,
      'verificationCode': _vCodeController.text,
    }, onSuccess: (data) {
      setState(() {
        tokenData = data;
        Dio dio = DioUtils.instance.getDio();
        dio.lock();
        saveToken(tokenData.token);
        dio.unlock();
        Router.pushReplacementNamed(context, Router.containerPage,data);
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
