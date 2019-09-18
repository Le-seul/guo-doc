class Togetheread{

  String id;
  String shortDesc;
  String coverImgId;
  int learnedUserCount;



  ///构造函数
  Togetheread.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortDesc = json['shortDesc'];
    coverImgId = json['coverImgId'];
    learnedUserCount = json['learnedUserCount'];

  }



}