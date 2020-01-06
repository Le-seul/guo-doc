class StepCount {
  String userId;
  String userName;
  int stepCount;
  int stepRanking;
  String image;

  StepCount({this.userId, this.userName, this.stepCount, this.stepRanking});

  StepCount.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    stepCount = json['stepCount'];
    stepRanking = json['stepRanking'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['stepCount'] = this.stepCount;
    data['stepRanking'] = this.stepRanking;
    data['image'] = this.image;
    return data;
  }
}