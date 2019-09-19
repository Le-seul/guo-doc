class Psycoursecatelog{
  String id;
  String courseId;
  String chapterName;
  //String detailDesc;
  int orderNo;
  int state;
  String learnedUserCount;

  Psycoursecatelog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['courseId'];
    chapterName = json['chapterName'];
    orderNo = json['orderNo'];
    state = json['state'];
    learnedUserCount = json['learnedUserCount'];
    //detailDesc = json['detailDesc'];

  }
}