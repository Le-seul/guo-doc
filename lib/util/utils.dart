

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
}
