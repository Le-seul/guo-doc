class ServiceActivity {

  String id;
  String name;
  String type;
  String cover;
  int state;
  int signInCount;


  ServiceActivity.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    type = json['type'];
    cover = json['cover'];
    state = json['state'];
    signInCount = json['signInCount'];

  }
}