class Information {
  var title;
  var source;
  var date;
  var image;

  Information.fromMap(Map<String, dynamic> map){
    title = map['title'];
    source = map['source'];
    date = map['date'];
    image = map['image'];
  }
}