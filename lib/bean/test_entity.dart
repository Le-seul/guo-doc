class TestTag {
  var categoryList;

  TestTag({this.categoryList});

  TestTag.fromJson(Map<String, dynamic> json) {
    categoryList = json['categoryList'];
  }
}