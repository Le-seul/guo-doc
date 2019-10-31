class PsyTeacherList{
  String id;
  String name;
  String imgId;
  int likeCount;
  String orgId;
  String shortDesc;
  String detailDesc;
  String major;
  String pqc;
  String remark;
  String slogan;
  String showId1;
  String showId2;
  String showId3;
  String showId4;


  PsyTeacherList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imgId = json['imgId'];
    likeCount = json['likeCount'];
    orgId = json['orgId'];
    shortDesc = json['shortDesc'];
    detailDesc = json['detailDesc'];
    major = json['major'];
    pqc = json['pqc'];
    remark = json['remark'];
    slogan = json['slogan'];
    showId1 = json['showId1'];
    showId4 = json['showId4'];
    showId3 = json['showId3'];
    showId2 = json['showId2'];


  }

}