class ChapterRecord {
  String courseId;
  String chapterId;
  int duration;
  String isFinish;

  ChapterRecord({this.courseId, this.chapterId, this.duration, this.isFinish});

  ChapterRecord.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    chapterId = json['chapterId'];
    duration = json['duration'];
    isFinish = json['isFinish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseId'] = this.courseId;
    data['chapterId'] = this.chapterId;
    data['duration'] = this.duration;
    data['isFinish'] = this.isFinish;
    return data;
  }
}