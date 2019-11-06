import 'package:flutter/material.dart';
import 'package:flutter_first/main.dart';
import 'package:flutter_first/util/config.dart';
import 'package:flutter_first/util/serviceLocator.dart';
import 'package:flutter_first/util/storage_manager.dart';

void main() async {
  Config.env = Env.TEST;
  setupLocator();
  await StorageManager.init();
  runApp(MyApp());
}

