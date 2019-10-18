import 'dart:io';

class Message {
  String contentId;
  String content;
  bool isPlaying ;
  String type = 'TW';
  String createTime;
  File file;

  Message({this.contentId, this.content, this.type, this.createTime,this.file,this.isPlaying});

  Message.fromJson(Map<String, dynamic> json) {
    contentId = json['contentId'];
    content = json['content'];
    type = json['type'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentId'] = this.contentId;
    data['content'] = this.content;
    data['type'] = this.type;
    data['createTime'] = this.createTime;
    return data;
  }
}