class TestLike {
  int testedUserCount;

  TestLike({
    this.testedUserCount,
  });

  factory TestLike.fromJson(Map<String, dynamic> json) => TestLike(
    testedUserCount: json["testedUserCount"],
  );

  Map<String, dynamic> toJson() => {
    "testedUserCount": testedUserCount,
  };
}
