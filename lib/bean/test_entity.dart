class TestTag {
  var regionList;

  TestTag({this.regionList});

  TestTag.fromJson(Map<String, dynamic> json) {
    regionList = json['tagList'];
  }
}