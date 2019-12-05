class PsyTeacher {
  String pqc;
  String imgId;
  int likeCount;
  dynamic remark;
  String orgId;
  String imgIdThumb;
  String detailDesc;
  String major;
  List<ShowImg> showImg;
  String name;
  String shortDesc;
  String id;
  int state;
  String slogan;

  PsyTeacher({
    this.pqc,
    this.imgId,
    this.likeCount,
    this.remark,
    this.orgId,
    this.imgIdThumb,
    this.detailDesc,
    this.major,
    this.showImg,
    this.name,
    this.shortDesc,
    this.id,
    this.state,
    this.slogan,
  });

  factory PsyTeacher.fromJson(Map<String, dynamic> json) => PsyTeacher(
    pqc: json["pqc"],
    imgId: json["imgId"],
    likeCount: json["likeCount"],
    remark: json["remark"],
    orgId: json["orgId"],
    imgIdThumb: json["imgIdThumb"],
    detailDesc: json["detailDesc"],
    major: json["major"],
    showImg: List<ShowImg>.from(json["ShowImg"].map((x) => ShowImg.fromJson(x))),
    name: json["name"],
    shortDesc: json["shortDesc"],
    id: json["id"],
    state: json["state"],
    slogan: json["slogan"],
  );

  Map<String, dynamic> toJson() => {
    "pqc": pqc,
    "imgId": imgId,
    "likeCount": likeCount,
    "remark": remark,
    "orgId": orgId,
    "imgIdThumb": imgIdThumb,
    "detailDesc": detailDesc,
    "major": major,
    "ShowImg": List<dynamic>.from(showImg.map((x) => x.toJson())),
    "name": name,
    "shortDesc": shortDesc,
    "id": id,
    "state": state,
    "slogan": slogan,
  };
}

class ShowImg {
  String showId;
  String showIdThumb;

  ShowImg({
    this.showId,
    this.showIdThumb,
  });

  factory ShowImg.fromJson(Map<String, dynamic> json) => ShowImg(
    showId: json["showId"] == null ? null : json["showId"],
    showIdThumb: json["showIdThumb"] == null ? null : json["showIdThumb"],
  );

  Map<String, dynamic> toJson() => {
    "showId": showId == null ? null : showId,
    "showIdThumb": showIdThumb == null ? null : showIdThumb,
  };
}
