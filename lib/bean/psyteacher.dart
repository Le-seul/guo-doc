class PsyTeacher {
  String detailDesc;
  String pqc;
  String imgId;
  String major;
  List<ShowImg> showImg;
  String name;
  String shortDesc;
  int likeCount;
  dynamic remark;
  String id;
  String slogan;
  String orgId;
  int state;
  PsyTeacher({
    this.detailDesc,
    this.pqc,
    this.imgId,
    this.major,
    this.showImg,
    this.name,
    this.shortDesc,
    this.likeCount,
    this.remark,
    this.id,
    this.slogan,
    this.orgId,
    this.state,
  });

  factory PsyTeacher.fromJson(Map<String, dynamic> json) => PsyTeacher(
    detailDesc: json["detailDesc"],
    pqc: json["pqc"],
    imgId: json["imgId"],
    major: json["major"],
    showImg: List<ShowImg>.from(json["ShowImg"].map((x) => ShowImg.fromJson(x))),
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
    "imgId": imgId,
    "major": major,
    "ShowImg": List<dynamic>.from(showImg.map((x) => x.toJson())),
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

class ShowImg {
  String showId;

  ShowImg({
    this.showId,
  });

  factory ShowImg.fromJson(Map<String, dynamic> json) => ShowImg(
    showId: json["showId"] == null ? null : json["showId"],
  );

  Map<String, dynamic> toJson() => {
    "showId": showId == null ? null : showId,
  };
}
