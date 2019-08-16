class ConsulationDetail {

  String canShare;
  int collectCount;
  String description;
  String title;
  int transmitCount;
  String content;
  String containAttachment;
  int shareCount;
  int readTimes;
  String relatedActivity;
  String articleType;
  String id;
  int state;
  String showReadTimes;
  String canCollect;
  String canTransmit;


  ConsulationDetail.fromJson(Map<String, dynamic> json) {
    canShare = json['canShare'];
    collectCount = json['collectCount'];
    description = json['description'];
    title = json['title'];
    transmitCount = json['transmitCount'];
    content = json['content'];
    containAttachment = json['containAttachment'];
    shareCount = json['shareCount'];
    readTimes = json['readTimes'];
    relatedActivity = json['relatedActivity'];
    articleType = json['articleType'];
    id = json['id'];
    state = json['state'];
    showReadTimes = json['showReadTimes'];
    canCollect = json['canCollect'];
    canTransmit = json['canTransmit'];

  }
}