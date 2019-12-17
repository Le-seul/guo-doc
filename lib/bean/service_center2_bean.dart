class ServCenter2 {
  String imgId;
  String name;
  String remark;
  String id;
  String type;
  String orgId;

  ServCenter2({
    this.imgId,
    this.name,
    this.remark,
    this.id,
    this.type,
    this.orgId,
  });

  factory ServCenter2.fromJson(Map<String, dynamic> json) => ServCenter2(
    imgId: json["imgId"],
    name: json["name"],
    remark: json["remark"],
    id: json["id"],
    type: json["type"],
    orgId: json["orgId"],
  );

  Map<String, dynamic> toJson() => {
    "imgId": imgId,
    "name": name,
    "remark": remark,
    "id": id,
    "type": type,
    "orgId": orgId,
  };
}
