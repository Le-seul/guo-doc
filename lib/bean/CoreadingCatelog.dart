class CoreadingCatelog {
  String categoryLevel1;
  List<CategoryLevel> categoryLevel;

  CoreadingCatelog({
    this.categoryLevel1,
    this.categoryLevel,
  });

  factory CoreadingCatelog.fromJson(Map<String, dynamic> json) => new CoreadingCatelog(
    categoryLevel1: json["categoryLevel1"],
    categoryLevel: new List<CategoryLevel>.from(json["categoryLevel"].map((x) => CategoryLevel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoryLevel1": categoryLevel1,
    "categoryLevel": new List<dynamic>.from(categoryLevel.map((x) => x.toJson())),
  };
}

class CategoryLevel {
  String detailDesc;
  int orderNo;
  String chapterName;
  String id;
  int state;
  String createTime;
  String afterClassQuestion;
  String learnedUserCount;

  CategoryLevel({
    this.detailDesc,
    this.orderNo,
    this.chapterName,
    this.id,
    this.createTime,
    this.state,
    this.afterClassQuestion,
    this.learnedUserCount,
  });

  factory CategoryLevel.fromJson(Map<String, dynamic> json) => new CategoryLevel(
    detailDesc: json["detailDesc"],
    orderNo: json["orderNo"],
    chapterName: json["chapterName"],
    createTime: json["createTime"],
    id: json["id"],
    state: json["state"],
    afterClassQuestion: json["afterClassQuestion"],
    learnedUserCount: json["learnedUserCount"],
  );

  Map<String, dynamic> toJson() => {
    "detailDesc": detailDesc,
    "orderNo": orderNo,
    "chapterName": chapterName,
    "createTime": createTime,
    "id": id,
    "state": state,
    "afterClassQuestion": afterClassQuestion,
    "learnedUserCount": learnedUserCount,
  };
}