class CourseTag {
  var categoryList;

  CourseTag({this.categoryList});

  CourseTag.fromJson(Map<String, dynamic> json) {
    categoryList = json['categoryList'];
  }
}