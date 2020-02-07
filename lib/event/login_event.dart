import 'dart:ui';

import 'package:event_bus/event_bus.dart';
import 'package:flutter_first/bean/course_detail.dart';

EventBus eventBus = EventBus();

class LoginEvent {
  String content;
  LoginEvent(this.content);
}
class Refresh {
  bool offstage;
  Refresh(this.offstage);
}

class refreshNum {
  String num;
  String orderId;
  String location;
  refreshNum(this.num, {this.orderId, this.location});
}

class CourseContent {
  ChapterList chapterList;
  int type;

  CourseContent(this.chapterList, this.type);
}

class CourseContent1 {
  ChapterList chapterList;
  int type;

  CourseContent1(this.chapterList, this.type);
}
