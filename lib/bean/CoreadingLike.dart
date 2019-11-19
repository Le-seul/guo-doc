class CoreadingLike {
  String detailDesc;

  CoreadingLike({
    this.detailDesc,
  });

  factory CoreadingLike.fromJson(Map<String, dynamic> json) => CoreadingLike(
    detailDesc: json["detailDesc"],
  );

  Map<String, dynamic> toJson() => {
    "detailDesc": detailDesc,
  };
}
