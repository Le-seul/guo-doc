class ArticleContent {
  String id;
  String title;
  String articleType;
  String description;
  int state;
  String canTransmit;
  String canLike;
  String canCollect;
  String showReadTimes;
  int transmitCount;
  int likeCount;
  int readTimes;
  int collectCount;
  String relatedActivity;
  String content;
  String containAttachment;

  ArticleContent(
      {this.id,
        this.title,
        this.articleType,
        this.description,
        this.state,
        this.canTransmit,
        this.canLike,
        this.canCollect,
        this.showReadTimes,
        this.transmitCount,
        this.likeCount,
        this.readTimes,
        this.collectCount,
        this.relatedActivity,
        this.content,
        this.containAttachment});

  ArticleContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    articleType = json['articleType'];
    description = json['description'];
    state = json['state'];
    canTransmit = json['canTransmit'];
    canLike = json['canLike'];
    canCollect = json['canCollect'];
    showReadTimes = json['showReadTimes'];
    transmitCount = json['transmitCount'];
    likeCount = json['likeCount'];
    readTimes = json['readTimes'];
    collectCount = json['collectCount'];
    relatedActivity = json['relatedActivity'];
    content = json['content'];
    containAttachment = json['containAttachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['articleType'] = this.articleType;
    data['description'] = this.description;
    data['state'] = this.state;
    data['canTransmit'] = this.canTransmit;
    data['canLike'] = this.canLike;
    data['canCollect'] = this.canCollect;
    data['showReadTimes'] = this.showReadTimes;
    data['transmitCount'] = this.transmitCount;
    data['likeCount'] = this.likeCount;
    data['readTimes'] = this.readTimes;
    data['collectCount'] = this.collectCount;
    data['relatedActivity'] = this.relatedActivity;
    data['content'] = this.content;
    data['containAttachment'] = this.containAttachment;
    return data;
  }
}