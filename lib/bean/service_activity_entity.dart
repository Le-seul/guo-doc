class ServiceActivity {

  String id;
  String name;
  String type;
  String cover;
  int state;
  String startTime;
  String endTime;
  String location;
  int signInCount;


  ServiceActivity.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    type = json['type'];
    cover = json['cover'];
    state = json['state'];
    signInCount = json['signInCount'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    location = json['location'];

  }
}