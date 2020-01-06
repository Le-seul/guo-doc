class StepRanking {
  int stepRanking;
  int stepCount;

  StepRanking({this.stepRanking, this.stepCount});

  StepRanking.fromJson(Map<String, dynamic> json) {
    stepRanking = json['stepRanking'];
    stepCount = json['stepCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stepRanking'] = this.stepRanking;
    data['stepCount'] = this.stepCount;
    return data;
  }
}