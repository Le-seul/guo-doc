class BannerImage{
  String id;
  String name;
  String type;
  String description;
  String imgId;
  int orderNumber;
  int state;
  String action;
  String actionTarget;

  BannerImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    imgId = json['imgId'];
    orderNumber = json['orderNumber'];
    state = json['state'];
    action = json['action'];
    actionTarget = json['actionTarget'];
  }
}