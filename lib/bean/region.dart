class RegionList {
  var regionList;

  RegionList({this.regionList});

  RegionList.fromJson(Map<String, dynamic> json) {
    regionList = json['regionList'];
  }
}