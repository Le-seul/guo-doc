

import 'package:flutter_first/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String getImgPath(String name) {
    return 'assets/images/$name';
  }

  static void launchTelURL(String phone) async {
    String url = 'tel:'+ phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('拨号失败！');
    }
  }

  static bool checkMobile(var sMobile){
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    bool matched = exp.hasMatch(sMobile);
    return matched;
  }

}
