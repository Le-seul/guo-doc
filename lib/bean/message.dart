class Message {
  String contentId;
  String content;
  int id;
  String localPath;
  bool isPlaying = false;
  String type = 'TW';
  String time;
//  String createTime;

  Message(
      {this.id,
      this.contentId,
      this.content,
      this.type,
        this.localPath,
//      this.createTime,
      this.isPlaying,
      this.time});

  Message.fromJson(Map<String, dynamic> json) {
    contentId = json['contentId'];
    content = json['content'];
    type = json['type'];
//    createTime = json['createTime'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentId'] = this.contentId;
    data['content'] = this.content;
    data['type'] = this.type;
    data['time'] = this.time;
//    data['createTime'] = this.createTime;
    return data;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['contentId'] = contentId;
    map['content'] = content;
    map['type'] = type;
    map['localPath'];
    map['time'] = time;
//    map['createTime'] = createTime;
    return map;
  }

  Message.fromMap(Map<String, dynamic> map) {
    contentId = map['contentId'];
    content = map['content'];
    type = map['type'];
    localPath = map['localPath'];
    time = map['time'];
//    createTime = map['createTime'];
  }
}
