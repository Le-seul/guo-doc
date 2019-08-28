class Psycourse{
  String id;
  String name;
  String categoryId;
  String shortDesc;
  int state;
  String coverImgId;
  String recmmend;
  String introPageImgId;
  String courseCount;
  int learnedUserCount;
  String image;

  Psycourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    categoryId = json['categoryId'];
    shortDesc = json['shortDesc'];
    state = json['state'];
    coverImgId = json['coverImgId'];
    recmmend = json['recmmend'];
    introPageImgId = json['introPageImgId'];
    courseCount = json['courseCount'];
    learnedUserCount = json['learnedUserCount'];

  }

}