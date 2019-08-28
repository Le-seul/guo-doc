class ActivityDetail{
  List<ChildActivity> childActivity;
  String id;
  String name;
  String type;
  String description;
  String cover;
  String parentActivityId;
  DateTime startTime;
  DateTime endTime;
  String location;
  String state;
  String detail;
  String onlineSignIn;
  String signInCount;
  String publishChanel;
  String chanelInfoMethod;

  ActivityDetail({
    this.childActivity,
    this.id,
    this.name,
    this.type,
    this.description,
    this.cover,
    this.parentActivityId,
    this.startTime,
    this.endTime,
    this.location,
    this.state,
    this.detail,
    this.onlineSignIn,
    this.signInCount,
    this.publishChanel,
    this.chanelInfoMethod,
  });


  factory ActivityDetail.fromJson(Map<String, dynamic> json) => new ActivityDetail(
    childActivity: new List<ChildActivity>.from(json["childActivity"].map((x) => ChildActivity.fromJson(x))),
    id: json["id"],
    name: json["name"],
    type: json["type"],
    description: json["description"],
    cover: json["cover"],
    parentActivityId: json["parentActivityId"],
    startTime: DateTime.parse(json["startTime"]),
    endTime: DateTime.parse(json["endTime"]),
    location: json["location"],
    state: json["state"],
    detail: json["detail"],
    onlineSignIn: json["onlineSignIn"],
    signInCount: json["signInCount"],
    publishChanel: json["publishChanel"],
    chanelInfoMethod: json["chanelInfoMethod"],
  );
}
class ChildActivity{
  String id;
  String name;
  String type;
  String cover;
  String state;

  ChildActivity({
    this.id,
    this.name,
    this.type,
    this.cover,
    this.state,
  });

  factory ChildActivity.fromJson(Map<String, dynamic> json) => new ChildActivity(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    cover: json["cover"],
    state: json["state"],
  );
}