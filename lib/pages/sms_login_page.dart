import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/user_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/util/utils.dart';
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
  String registrationID = '';
  /// 当前秒数
  int s;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    registrationID = StorageManager.sharedPreferences.getString(Constant.registrationID);
    print('极光 id：$registrationID');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: loadAssetImage('login/logo.png',
                  fit: BoxFit.cover, height: 100, width: 100),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "畅享健康",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 30,
            ),
            MyTextField(
              controller: _phoneController,
              maxLength: 11,
              prefixIcon: 'login/mobile.png',
              keyboardType: TextInputType.phone,
              hintText: "请输入手机号",
            ),
            SizedBox(
              height: 30,
            ),
            _myTextField(),
            SizedBox(
              height: 35,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(26)),
              child: FlatButton(
                  onPressed: () {
                    _checkVerificationCode();
                  },
                  child: Text(
                    '登录',
                    style: TextStyle(color: Colors.white,fontSize: 20),
                  )),
            )

          ],
        ),
      ),
      resizeToAvoidBottomPadding: false, //输入框抵住键盘
    );
  }

  _myTextField() {
    return Container(
        padding: EdgeInsets.only(left: 10,right: 8),
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(26)),
        child: Stack(alignment: Alignment.centerRight, children: <Widget>[
          TextField(
            maxLength: 6,
            autofocus: false,
            cursorColor: Colors.green,
            controller: _vCodeController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
              hintText: "请输入验证码",
              counterText: "",
              prefixIcon: Container(
                padding: EdgeInsets.all(12),
                child: loadAssetImage('login/password.png',
                    width: 5, height: 5, fit: BoxFit.fitHeight),
              ),
              border: InputBorder.none,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(width: 1.5,height:18,color: Colors.green,),
              SizedBox(width: 5,),
              Container(

                  child: FlatButton(
                    onPressed: _isClick
                        ? () {
                      if(Utils.checkMobile(_phoneController.text)){
                        _sendVerificationCode();
                      }else{
                        Toast.show('请输入正确手机号!');
                      }

                    } : null,

                    textColor: Colors.black,
                    child: Text(
                      !_isClick ? "（$s s）" : "获取验证码",
                      style: TextStyle(fontSize: 13, color: Colors.green),
                    ),
                  ),
                ),
            ],
          ),

        ]));
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
        _subscription = Observable.periodic(Duration(seconds: 1), (i) => i)
            .take(second)
            .listen((i) {
          setState(() {
            s = second - i - 1;
            _isClick = s < 1;
          });
        });
        savePhone(_phoneController.text);
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

  static savePhone(String phone) async {
    StorageManager.sharedPreferences.setString(Constant.phone, phone);
  }
  static saveToken(String token) async {
    StorageManager.sharedPreferences.setString(Constant.access_Token, token);
  }

  _checkVerificationCode() async {
    DioUtils.instance
        .requestNetwork<Token>(Method.post, Api.CHECKVCODE, queryParameters: {
      'userId': widget.user.userId,
      'verificationCode': _vCodeController.text,
    }, onSuccess: (data) {
      setState(() {
        Toast.show('验证成功!');
        tokenData = data;
        Dio dio = DioUtils.instance.getDio();
        dio.lock();
        saveToken(tokenData.token);
        dio.unlock();
        _updateRegistrationID();
        Router.pushReplacementNamed(context, Router.containerPage, data);
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

  void _updateRegistrationID() {
    print("极光Id：$registrationID");
    if(registrationID!=null){
      DioUtils.instance.requestNetwork<String>(
          Method.post, Api.UPDATEREGISTRATIONID,
          queryParameters: {
            'deviceType': "android",
            'registrationID': registrationID,
          }, onSuccess: (data) {
        setState(() {
          print('上传registrationID成功!');
        });
      }, onError: (code, msg) {
        setState(() {
          print('上传registrationID失败!');
        });
      });
    }
  }
}
