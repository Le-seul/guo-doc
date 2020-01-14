class Coreadinglist {
  var tagList;

  Coreadinglist({this.tagList});

  Coreadinglist.fromJson(Map<String, dynamic> json) {
    tagList = json['tagList'];
  }
}