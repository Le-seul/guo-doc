class Collection {
  String canLike;
  int collectCount;
  String description;
  int likeCount;
  String title;
  int transmitCount;
  int readCount;
  String content;
  String articleType;
  dynamic cover2;
  String cover1;
  String id;
  int state;
  String showReadTimes;
  String canCollect;
  dynamic cover3;
  String canTransmit;

  Collection({
    this.canLike,
    this.collectCount,
    this.description,
    this.likeCount,
    this.title,
    this.transmitCount,
    this.readCount,
    this.content,
    this.articleType,
    this.cover2,
    this.cover1,
    this.id,
    this.state,
    this.showReadTimes,
    this.canCollect,
    this.cover3,
    this.canTransmit,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    canLike: json["canLike"],
    collectCount: json["collectCount"],
    description: json["description"],
    likeCount: json["likeCount"],
    title: json["title"],
    transmitCount: json["transmitCount"],
    readCount: json["readCount"],
    content: json["content"],
    articleType: json["articleType"],
    cover2: json["cover2"],
    cover1: json["cover1"],
    id: json["id"],
    state: json["state"],
    showReadTimes: json["showReadTimes"],
    canCollect: json["canCollect"],
    cover3: json["cover3"],
    canTransmit: json["canTransmit"],
  );

  Map<String, dynamic> toJson() => {
    "canLike": canLike,
    "collectCount": collectCount,
    "description": description,
    "likeCount": likeCount,
    "title": title,
    "transmitCount": transmitCount,
    "readCount": readCount,
    "content": content,
    "articleType": articleType,
    "cover2": cover2,
    "cover1": cover1,
    "id": id,
    "state": state,
    "showReadTimes": showReadTimes,
    "canCollect": canCollect,
    "cover3": cover3,
    "canTransmit": canTransmit,
  };
}