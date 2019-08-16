class ConsulationColumnsInfo {

  String id;
  String type;
  String articleType;
  String description;
  String cover1;
  String cover2;
  String cover3;
  int state;
  String canTransmit;
  String title;
  String canCollect;
  String showReadTimes;
  int transmitCount;
  int likeCount;
  int readCount;
  int collectCount;
  String content;
  String canLike;


  ConsulationColumnsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    articleType = json['articleType'];
    description = json['description'];
    cover1 = json['cover1'];
    cover2 = json['cover2'];
    cover3 = json['cover3'];
    state = json['state'];
    canTransmit = json['canTransmit'];
    title = json['title'];
    canCollect = json['canCollect'];
    showReadTimes = json['showReadTimes'];
    transmitCount = json['transmitCount'];
    likeCount = json['likeCount'];
    readCount = json['readCount'];
    collectCount = json['collectCount'];
    content = json['content'];
    canLike = json['canLike'];
  }
}