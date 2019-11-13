class CourseBookmark {
  String courseId;
  String chapterId;
  int duration;

  CourseBookmark({this.courseId, this.chapterId, this.duration});

  CourseBookmark.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    chapterId = json['chapterId'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseId'] = this.courseId;
    data['chapterId'] = this.chapterId;
    data['duration'] = this.duration;
    return data;
  }
}