
import 'package:doubanapp/constant/constant.dart';
import 'package:flutter/widgets.dart';

class DataProviderWidget<T> extends InheritedWidget {
  T data;

  DataProviderWidget({Key key, Widget child, this.data}): super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return data != (oldWidget as DataProviderWidget).data;
  }

  static T of<T>(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(
        DataProviderWidget<T>().runtimeType) as DataProviderWidget<T>).data;
  }

}

class GlobalUserData {
  double foodCardMoney = 50;
  String userId;
  String userName = "张警官";
  String avatarUrl = Constant.ASSETS_IMG+"sc_user_avatar.jpg";
  String orgnization = "北京市公安局警备保障部";
  String phone;
  bool isBirthday = true;
}