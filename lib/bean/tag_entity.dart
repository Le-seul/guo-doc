class Tag {
  var categoryList;

  Tag({this.categoryList});

  Tag.fromJson(Map<String, dynamic> json) {
    categoryList = json['categoryList'];
  }
}