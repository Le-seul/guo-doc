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


  }

}