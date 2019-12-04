class Clinic {
  String detailDesc;
  String post;
  String imgId;
  String name;
  String id;
  String workTime;

  Clinic({
    this.detailDesc,
    this.post,
    this.imgId,
    this.name,
    this.id,
    this.workTime,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
    detailDesc: json["detailDesc"],
    post: json["post"],
    imgId: json["imgId"],
    name: json["name"],
    id: json["id"],
    workTime: json["workTime"],
  );

  Map<String, dynamic> toJson() => {
    "detailDesc": detailDesc,
    "post": post,
    "imgId": imgId,
    "name": name,
    "id": id,
    "workTime": workTime,
  };
}