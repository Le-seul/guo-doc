import 'dart:ui';

import 'package:event_bus/event_bus.dart';
import 'package:flutter_first/bean/course_detail.dart';

EventBus eventBus = EventBus();
class LoginEvent{

}
class refreshNum{
  String num;
  String orderId;
  String location;
  refreshNum(this.num,{this.orderId,this.location});
}

class CourseContent{
  int index;
  int type;

  CourseContent(this.index,this.type);
}