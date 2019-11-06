class PsyServiceCenter{
  String imgId ;
  String name;
  String location;
  String shortDesc;
  String remark;
  String orgId;

  PsyServiceCenter.fromJson(Map<String, dynamic> json) {
    imgId = json['imgId'];
    name = json['name'];
    location = json['location'];
    shortDesc = json['shortDesc'];
    remark = json['remark'];
    orgId = json['orgId'];
  }

}