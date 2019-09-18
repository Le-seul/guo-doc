class PsyDailyTest {
  String questionCount;
  String coverImgId;
  int testedUserCount;
  String shortDesc;
  String id;
  int state;
  String title;

  PsyDailyTest({
    this.questionCount,
    this.coverImgId,
    this.testedUserCount,
    this.shortDesc,
    this.id,
    this.state,
    this.title,
  });

  factory PsyDailyTest.fromJson(Map<String, dynamic> json) => PsyDailyTest(
    questionCount: json["questionCount"],
    coverImgId: json["coverImgId"],
    testedUserCount: json["testedUserCount"],
    shortDesc: json["shortDesc"],
    id: json["id"],
    state: json["state"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "questionCount": questionCount,
    "coverImgId": coverImgId,
    "testedUserCount": testedUserCount,
    "shortDesc": shortDesc,
    "id": id,
    "state": state,
    "title": title,
  };
}
