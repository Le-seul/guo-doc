import 'package:flutter_first/common/common.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {

  static SharedPreferences sharedPreferences;
  static JPush jpush;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    jpush = new JPush();
  }

  static exite() async {
    await StorageManager.sharedPreferences.setString(Constant.access_Token, '');
  }

}
