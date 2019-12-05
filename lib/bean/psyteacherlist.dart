class PsyTeacherList {
  String detailDesc;
  String pqc;
  String imgIdThumb;
  String major;
  String name;
  String shortDesc;
  int likeCount;
  dynamic remark;
  String id;
  String slogan;
  String orgId;
  int state;

  PsyTeacherList({
    this.detailDesc,
    this.pqc,
    this.imgIdThumb,
    this.major,
    this.name,
    this.shortDesc,
    this.likeCount,
    this.remark,
    this.id,
    this.slogan,
    this.orgId,
    this.state
  });

  factory PsyTeacherList.fromJson(Map<String, dynamic> json) => PsyTeacherList(
    detailDesc: json["detailDesc"],
    pqc: json["pqc"],
    imgIdThumb: json["imgIdThumb"],
    major: json["major"],
    name: json["name"],
    shortDesc: json["shortDesc"],
    likeCount: json["likeCount"],
    remark: json["remark"],
    id: json["id"],
    slogan: json["slogan"],
    orgId: json["orgId"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "detailDesc": detailDesc,
    "pqc": pqc,
    "imgIdThumb": imgIdThumb,
    "major": major,
    "name": name,
    "shortDesc": shortDesc,
    "likeCount": likeCount,
    "remark": remark,
    "id": id,
    "slogan": slogan,
    "orgId": orgId,
    "state": state,
  };
}