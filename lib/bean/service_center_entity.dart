class ServiceCenter {

  var name;
  var image;


  ///构造函数
  ServiceCenter.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    image = map['image'];
  }
}