import 'dart:async';

import 'package:flutter_first/bean/chunyu_message.dart';
import 'package:flutter_first/block/bloc_provider.dart';

class ChunyuPushBloc implements BlocBase {

  var _countController = StreamController<ChunyuMessage>.broadcast();

  Stream<ChunyuMessage> get stream => _countController.stream;
  Sink<ChunyuMessage> get sink => _countController.sink;

  void dispose(){
    _countController.close();
  }
}