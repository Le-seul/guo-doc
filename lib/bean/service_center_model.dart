class SeviceLocation {
  String id;
  String name;
  String location;
  int state;

  SeviceLocation({this.id, this.name, this.location, this.state});

  SeviceLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    state = json['state'];
  }
}