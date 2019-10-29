import 'dart:ui';

import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();
class LoginEvent{

}
class refreshNum{
  String num;
  String orderId;
  String location;
  refreshNum(this.num,{this.orderId,this.location});
}