class Course {
  String id;
  String name;
  String category;
  String shortDescription;
  String coverImage;
  int learnedUserCount;
  int courseCount;
  String state;
  String publishTime;

  Course(
      {this.id,
        this.name,
        this.category,
        this.shortDescription,
        this.coverImage,
        this.learnedUserCount,
        this.courseCount,
        this.state,
        this.publishTime});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    shortDescription = json['shortDescription'];
    coverImage = json['coverImage'];
    learnedUserCount = json['learnedUserCount'];
    courseCount = json['courseCount'];
    state = json['state'];
    publishTime = json['publishTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['shortDescription'] = this.shortDescription;
    data['coverImage'] = this.coverImage;
    data['learnedUserCount'] = this.learnedUserCount;
    data['courseCount'] = this.courseCount;
    data['state'] = this.state;
    data['publishTime'] = this.publishTime;
    return data;
  }
}