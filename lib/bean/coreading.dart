class CoReading{

  String detailDesc;
  String shortDesc;
  String coverImgId;
  String id;
  String name;
  int learnedUserCount;


  ///构造函数
  CoReading.fromJson(Map<String, dynamic> json) {
    detailDesc = json['detailDesc'];
    shortDesc = json['shortDesc'];
    coverImgId = json['coverImgId'];
    id = json['id'];
    name = json['name'];
    learnedUserCount = json['learnedUserCount'];

  }



}