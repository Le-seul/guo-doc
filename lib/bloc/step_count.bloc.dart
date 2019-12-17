import 'dart:async';
import 'package:flutter_first/bloc/bloc_provider.dart';

class StepCountBloc implements BlocBase {

  var _countController = StreamController<int>.broadcast();

  Stream<int> get stream => _countController.stream;
  Sink<int> get sink => _countController.sink;

  void dispose(){
    _countController.close();
  }
}