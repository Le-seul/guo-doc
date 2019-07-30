import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

///模拟数据
class MockRequest {

  Future<dynamic> get(String action, {Map params}) async {
    return MockRequest.mock(action: action, params: params);
  }

  static Future<dynamic> post({String action, Map params}) async {
    return MockRequest.mock(action: action, params: params);
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$action${params['pageNume']}.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }



}
