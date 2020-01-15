class ActivityDetail {
  List<ChildActivity> childActivity;
  String id;
  String name;
  String type;
  String description;
  String cover;
  String parentActivityId;
  String startTime;
  String endTime;
  String location;
  int state;
  String detail;
  String onlineSignIn;
  int signInCount;
  String publishChanel;
  String chanelInfoMethod;
  List<ArticleList> articleList;
  List<QuestionnaireList> questionnaireList;
  String isSignUp;
  List<QuestionnaireCollectionList> questionnaireCollectionList;

  ActivityDetail(
      {this.childActivity,
        this.id,
        this.name,
        this.type,
        this.description,
        this.cover,
        this.parentActivityId,
        this.startTime,
        this.endTime,
        this.location,
        this.state,
        this.detail,
        this.onlineSignIn,
        this.signInCount,
        this.publishChanel,
        this.chanelInfoMethod,
        this.articleList,
        this.questionnaireList,
        this.isSignUp,
        this.questionnaireCollectionList});

  ActivityDetail.fromJson(Map<String, dynamic> json) {
    if (json['childActivity'] != null) {
      childActivity = new List<ChildActivity>();
      json['childActivity'].forEach((v) {
        childActivity.add(new ChildActivity.fromJson(v));
      });
    }
    id = json['id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    cover = json['cover'];
    parentActivityId = json['parentActivityId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    location = json['location'];
    state = json['state'];
    detail = json['detail'];
    onlineSignIn = json['onlineSignIn'];
    signInCount = json['signInCount'];
    publishChanel = json['publishChanel'];
    chanelInfoMethod = json['chanelInfoMethod'];
    if (json['articleList'] != null) {
      articleList = new List<ArticleList>();
      json['articleList'].forEach((v) {
        articleList.add(new ArticleList.fromJson(v));
      });
    }
    if (json['questionnaireList'] != null) {
      questionnaireList = new List<QuestionnaireList>();
      json['questionnaireList'].forEach((v) {
        questionnaireList.add(new QuestionnaireList.fromJson(v));
      });
    }
    isSignUp = json['isSignUp'];
    if (json['questionnaireCollectionList'] != null) {
      questionnaireCollectionList = new List<QuestionnaireCollectionList>();
      json['questionnaireCollectionList'].forEach((v) {
        questionnaireCollectionList
            .add(new QuestionnaireCollectionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.childActivity != null) {
      data['childActivity'] =
          this.childActivity.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['description'] = this.description;
    data['cover'] = this.cover;
    data['parentActivityId'] = this.parentActivityId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['location'] = this.location;
    data['state'] = this.state;
    data['detail'] = this.detail;
    data['onlineSignIn'] = this.onlineSignIn;
    data['signInCount'] = this.signInCount;
    data['publishChanel'] = this.publishChanel;
    data['chanelInfoMethod'] = this.chanelInfoMethod;
    if (this.articleList != null) {
      data['articleList'] = this.articleList.map((v) => v.toJson()).toList();
    }
    if (this.questionnaireList != null) {
      data['questionnaireList'] =
          this.questionnaireList.map((v) => v.toJson()).toList();
    }
    data['isSignUp'] = this.isSignUp;
    if (this.questionnaireCollectionList != null) {
      data['questionnaireCollectionList'] =
          this.questionnaireCollectionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildActivity {
  String id;
  String name;
  String type;
  String cover;
  int state;

  ChildActivity({this.id, this.name, this.type, this.cover, this.state});

  ChildActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    cover = json['cover'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['cover'] = this.cover;
    data['state'] = this.state;
    return data;
  }
}

class ArticleList {
  String id;
  String title;
  String cover;

  ArticleList({this.id, this.title, this.cover});

  ArticleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cover'] = this.cover;
    return data;
  }
}

class QuestionnaireList {
  String id;
  String title;
  String cover;
  String isFinished;

  QuestionnaireList({this.id, this.title, this.cover, this.isFinished});

  QuestionnaireList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
    isFinished = json['isFinished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['isFinished'] = this.isFinished;
    return data;
  }
}

class QuestionnaireCollectionList {
  String id;
  String name;
  List<QuestionnaireChildList> questionnaireList;
  String cover;

  QuestionnaireCollectionList(
      {this.id, this.name, this.questionnaireList, this.cover});

  QuestionnaireCollectionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['questionnaireList'] != null) {
      questionnaireList = new List<QuestionnaireChildList>();
      json['questionnaireList'].forEach((v) {
        questionnaireList.add(new QuestionnaireChildList.fromJson(v));
      });
    }
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.questionnaireList != null) {
      data['questionnaireList'] =
          this.questionnaireList.map((v) => v.toJson()).toList();
    }
    data['cover'] = this.cover;
    return data;
  }
}

class QuestionnaireChildList {
  String id;
  String isFinished;

  QuestionnaireChildList({this.id, this.isFinished});

  QuestionnaireChildList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isFinished = json['isFinished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isFinished'] = this.isFinished;
    return data;
  }
}