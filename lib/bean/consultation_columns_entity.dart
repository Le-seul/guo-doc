class ConsulationColumns {

  String id;
  String name;
  String code;
  String type;
  String description;
  int level;
  int parentId;
  int orderNumber;


  ConsulationColumns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    description = json['description'];
    level = json['level'];
    parentId = json['parentId'];
    orderNumber = json['orderNumber'];

  }
}