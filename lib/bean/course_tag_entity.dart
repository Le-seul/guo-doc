class CourseTag {
  var tagList;

  CourseTag({this.tagList});

  CourseTag.fromJson(Map<String, dynamic> json) {
    tagList = json['tagList'];
  }
}