class ServiceActivity {


  String id;
  String name;
  int type;
  String description;
  String cover;
  String parentActivityId;
  String endTime;
  String startTime;
  String location;
  String detail;
  int state;
  String onlineSignIn;
  int signInCount;
  String publishChanel;
  String chanelInfoMethod;


  ServiceActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    description = json['description'];
    cover = json['cover'];
    parentActivityId = json['parentActivityId'];
    endTime = json['endTime'];
    startTime = json['startTime'];
    location = json['location'];
    detail = json['detail'];
    state = json['state'];
    onlineSignIn = json['onlineSignIn'];
    signInCount = json['signInCount'];
    publishChanel = json['publishChanel'];
    chanelInfoMethod = json['chanelInfoMethod'];

  }
}