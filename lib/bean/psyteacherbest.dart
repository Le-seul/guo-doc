class PsyTeacherBest{
  String id;
  String name;
  String imgId;
  String major;
  String orgId;
  String shortDesc;
  String detailDesc;
  String pqc;
  String slogan;
  int likeCount;
  String showId1;
  String showId2;
  String showId3;
  String showId4;

  PsyTeacherBest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imgId = json['imgId'];
    major = json['major'];
    orgId = json['orgId'];
    shortDesc = json['shortDesc'];
    detailDesc = json['detailDesc'];
    pqc = json['pqc '];
    slogan = json['slogan'];
    likeCount = json['likeCount'];
    showId1 = json['showId1'];
    showId4 = json['showId4'];
    showId3 = json['showId3'];
    showId2 = json['showId2'];


  }

}