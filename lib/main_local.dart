import 'package:flutter/material.dart';
import 'package:flutter_first/main.dart';
import 'package:flutter_first/net/config.dart';
import 'package:flutter_first/util/serviceLocator.dart';
import 'package:flutter_first/util/storage_manager.dart';

void main() async {
  Config.env = Env.LOCAL;
  setupLocator();
  await StorageManager.init();
  runApp(MyApp());
}
