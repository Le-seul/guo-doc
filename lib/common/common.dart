class Constant {
  static const String key_guide = 'key_guide';
  static const String phone = 'phone';
  static const String access_Token = 'accessToken';
  static const String token = 'token';
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