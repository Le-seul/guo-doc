import 'package:get_it/get_it.dart';
import './tel_service.dart';

GetIt locator = GetIt();
void setupLocator() {
  locator.registerSingleton(TelAndSmsService());
}