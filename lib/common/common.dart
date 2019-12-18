class Constant {
  static const String orderId = 'orderId';
  static const String userInfo = 'userInfo';
  static const String userName = 'userName';
  static const String userPassward = 'userPassward';
  static const String phone = 'phone';
  static const String registrationID = 'registrationID';
  static const String tuWenNum = 'tuWenNum';
  static const String fastFhoneNum = 'fastFhoneNum';
  static const String access_Token = 'accessToken';
  static const String onlinIsAgree = 'onlinIsAgree';
  static const String psychologicalIsAgree = 'psychologicalIsAgree';
  static const String refresh_Token = 'refreshToken';

}
class Token{
  String token;

  Token.fromJson(Map<String, dynamic> json) {
    if(json != null){
      token = json['token'];
    }
  }
}
class OrderId{
  String orderId;

  OrderId.fromJson(Map<String, dynamic> json) {
    if(json != null){
      orderId = json['orderId'];
    }
  }
}