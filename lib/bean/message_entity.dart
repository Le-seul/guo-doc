class MessageEntity {
  String content;
  String time;
  String model;
  String type;

  MessageEntity({this.content, this.time, this.model, this.type});

  MessageEntity.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    time = json['time'];
    model = json['model'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['time'] = this.time;
    data['model'] = this.model;
    data['type'] = this.type;
    return data;
  }
}