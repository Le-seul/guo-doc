class Psycoursecatelog{
  String id;
  String name;
  String chapterName;
  String detailDesc;
  int orderNo;
  int state;
  String learnedUserCount;

  Psycoursecatelog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    chapterName = json['chapterName'];
    orderNo = json['orderNo'];
    state = json['state'];
    learnedUserCount = json['learnedUserCount'];
    detailDesc = json['detailDesc'];

  }
}