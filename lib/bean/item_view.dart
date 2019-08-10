class ItemView {

  var title;
  var icon;


  ItemView(this.title, this.icon);

  ///构造函数
  ItemView.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    icon = map['icon'];
  }
}