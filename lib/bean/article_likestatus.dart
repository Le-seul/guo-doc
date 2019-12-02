class LikeStatus {
  int likeStatus;
  String articleId;
  int collectStatus;

  LikeStatus({this.likeStatus = 0, this.articleId, this.collectStatus = 0});

  LikeStatus.fromJson(Map<String, dynamic> json) {
    likeStatus = json['likeStatus'];
    articleId = json['articleId'];
    collectStatus = json['collectStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likeStatus'] = this.likeStatus;
    data['articleId'] = this.articleId;
    data['collectStatus'] = this.collectStatus;
    return data;
  }
}