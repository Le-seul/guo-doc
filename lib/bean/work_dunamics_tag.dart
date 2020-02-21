class WorkTag {
  var tagList;

  WorkTag({this.tagList});

  WorkTag.fromJson(Map<String, dynamic> json) {
    tagList = json['tagList'];
  }
}