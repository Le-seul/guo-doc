class PsyDailyTest {
  String id;
  String questionCount;
  String coverImgId;
  int testedUserCount;
  String shortDesc;
  int state;
  String title;
  String testEntry;

  PsyDailyTest({
    this.id,
    this.questionCount,
    this.coverImgId,
    this.testedUserCount,
    this.shortDesc,
    this.state,
    this.title,
    this.testEntry,

  });

  factory PsyDailyTest.fromJson(Map<String, dynamic> json) => PsyDailyTest(
    id: json["id"],
    questionCount: json["questionCount"],
    coverImgId: json["coverImgId"],
    testedUserCount: json["testedUserCount"],
    shortDesc: json["shortDesc"],
    state: json["state"],
    title: json["title"],
    testEntry: json["testEntry"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionCount": questionCount,
    "coverImgId": coverImgId,
    "testedUserCount": testedUserCount,
    "shortDesc": shortDesc,
    "state": state,
    "title": title,
    "testEntry": testEntry,

  };
}
