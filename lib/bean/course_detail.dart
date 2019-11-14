class CourseDetail {
  String id;
  String name;
  String category;
  String shortDescription;
  String detailDescription;
  String image;
  int courseCount;
  int learnedUserCount;

  List<ChapterList> chapterList;

  CourseDetail(
      {this.id,
        this.name,
        this.category,
        this.shortDescription,
        this.detailDescription,
        this.image,
        this.courseCount,
        this.learnedUserCount,
        this.chapterList,

      });

  CourseDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    shortDescription = json['shortDescription'];
    detailDescription = json['detailDescription'];
    image = json['image'];
    courseCount = json['courseCount'];
    learnedUserCount = json['learnedUserCount'];
    if (json['chapterList'] != null) {
      chapterList = new List<ChapterList>();
      json['chapterList'].forEach((v) {
        chapterList.add(new ChapterList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['shortDescription'] = this.shortDescription;
    data['detailDescription'] = this.detailDescription;
    data['image'] = this.image;
    data['courseCount'] = this.courseCount;
    data['learnedUserCount'] = this.learnedUserCount;
    if (this.chapterList != null) {
      data['chapterList'] = this.chapterList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChapterList {
  String chapterId;
  bool isHighlight = false;
  String name;
  int order;
  String state ;
  int duration;
  bool isPlaying = false;
  String detailDescription;
  int learnedUserCount;
  String audio;

  ChapterList(
      {this.chapterId,
        this.name,
        this.order,
        this.detailDescription,
        this.learnedUserCount,
        this.audio,
        this.isPlaying = false,
        this.state,
        this.duration
      });

  ChapterList.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapterId'];
    name = json['name'];
    order = json['order'];
    detailDescription = json['detailDescription'];
    learnedUserCount = json['learnedUserCount'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapterId'] = this.chapterId;
    data['name'] = this.name;
    data['order'] = this.order;
    data['detailDescription'] = this.detailDescription;
    data['learnedUserCount'] = this.learnedUserCount;
    data['audio'] = this.audio;
    return data;
  }
}