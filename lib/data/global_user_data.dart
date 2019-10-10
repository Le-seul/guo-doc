
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
  String userId;
  //是否在后台播放音乐，如果是，则显示浮动按钮
  bool isPlayMusicBackground;
}