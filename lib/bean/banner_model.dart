class BannerModel {
  String title;
  String url;
  String imagePath;

  BannerModel.fromMap(Map<String, dynamic> map) {

    title = map['title'];
    url = map['url'];
    imagePath = map['imagePath'];
  }

  BannerModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        url = json['url'],
        imagePath = json['imagePath'];

  Map<String, dynamic> toJson() => {
    'title': title,
    'url': url,
    'imagePath': imagePath,
  };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imagePath\":\"$imagePath\"");
    sb.write('}');
    return sb.toString();
  }
}