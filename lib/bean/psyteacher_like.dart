class PsyTeacherLike {
  int likeCount;
  int state;

  PsyTeacherLike({
    this.likeCount,
    this.state,
  });

  factory PsyTeacherLike.fromJson(Map<String, dynamic> json) => PsyTeacherLike(
    likeCount: json["likeCount"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "likeCount": likeCount,
    "state": state,
  };
}
