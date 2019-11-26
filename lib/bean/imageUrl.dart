class ImageUrl {
  String url;
  String id;

  ImageUrl({this.url,this.id});

  ImageUrl.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    if(json['id'] != null){
      id = json['id'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}