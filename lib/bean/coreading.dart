class CoReading{

  String detailDesc;
  String shortDesc;
  String coverImgId;
  String id;
  int learnedUserCount;


  ///构造函数
  CoReading.fromJson(Map<String, dynamic> json) {
    detailDesc = json['detailDesc'];
    shortDesc = json['shortDesc'];
    coverImgId = json['coverImgId'];
    id = json['id'];
    learnedUserCount = json['learnedUserCount'];

  }



}