class HealthAdv {

  var title;
  var net_name;
  var num;
  Images images;


  ///构造函数
  HealthAdv.fromMap(Map<String, dynamic> map) {

    title = map['title'];
    net_name = map['net_name'];
    var img = map['images'];
    images = Images(img['small'], img['large'], img['medium']);
    num = map['num'];
  }
}
class Images {
  var small;
  var large;
  var medium;

  Images(this.small, this.large, this.medium);
}