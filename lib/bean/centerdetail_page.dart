class CenterDetail {
  dynamic detailDesc;
  String imgId;
  String phone;
  String conTime;
  String name;
  String location;
  dynamic shortDesc;
  dynamic remark;
  String id;
  dynamic type;
  String scId;
  String contacts;

  CenterDetail({
    this.detailDesc,
    this.imgId,
    this.phone,
    this.conTime,
    this.name,
    this.location,
    this.shortDesc,
    this.remark,
    this.id,
    this.type,
    this.scId,
    this.contacts,
  });

  factory CenterDetail.fromJson(Map<String, dynamic> json) => CenterDetail(
    detailDesc: json["detailDesc"],
    imgId: json["imgId"],
    phone: json["phone"],
    conTime: json["conTime"],
    name: json["name"],
    location: json["location"],
    shortDesc: json["shortDesc"],
    remark: json["remark"],
    id: json["id"],
    type: json["type"],
    scId: json["scId"],
    contacts: json["contacts"],
  );

  Map<String, dynamic> toJson() => {
    "detailDesc": detailDesc,
    "imgId": imgId,
    "phone": phone,
    "conTime": conTime,
    "name": name,
    "location": location,
    "shortDesc": shortDesc,
    "remark": remark,
    "id": id,
    "type": type,
    "scId": scId,
    "contacts": contacts,
  };
}
