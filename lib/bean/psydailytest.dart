class PsyDailyTest {
  String questionId;
  String coverImgId;
  int testedUserCount;
  String description;
  String title;

  PsyDailyTest({
    this.coverImgId,
    this.testedUserCount,
    this.title,
    this.description,
    this.questionId,

  });

  factory PsyDailyTest.fromJson(Map<String, dynamic> json) => PsyDailyTest(
    coverImgId: json["coverImgId"],
    testedUserCount: json["testedUserCount"],
    title: json["title"],
    description: json["description"],
    questionId: json["questionId"],

  );

  Map<String, dynamic> toJson() => {
    "coverImgId": coverImgId,
    "testedUserCount": testedUserCount,
    "title": title,
    "description": description,
    "questionId": questionId,

  };
}
