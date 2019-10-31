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


  }

}