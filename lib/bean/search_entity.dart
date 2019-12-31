class SearchContent {
  String model;
  String modelName;
  List<ListContent> list;

  SearchContent({this.model, this.list,this.modelName});

  SearchContent.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    modelName = json['modelName'];
    if (json['list'] != null) {
      list = new List<ListContent>();
      json['list'].forEach((v) {
        list.add(new ListContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListContent {
  String id;
  String title;
  String image;

  ListContent({this.id, this.title,this.image});

  ListContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }

  @override
  String toString() {
    return title;
  }

}