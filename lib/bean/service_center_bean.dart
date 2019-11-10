class ServCenter {
  String name;
  String imgId;
  String remark;
  String id;
  bool offstage = true;
  List<ServiceStation> serviceStation;
  List<LeisurePost> leisurePost;

  ServCenter(
      {this.name,
        this.imgId,
        this.remark,
        this.id,
        this.serviceStation,
        this.leisurePost,
      this.offstage = true});

  ServCenter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imgId = json['imgId'];
    id = json['id'];
    remark = json['remark'];
    if (json['ServiceStation'] != null) {
      serviceStation = new List<ServiceStation>();
      json['ServiceStation'].forEach((v) {
        serviceStation.add(new ServiceStation.fromJson(v));
      });
    }
    if (json['LeisurePost'] != null) {
      leisurePost = new List<LeisurePost>();
      json['LeisurePost'].forEach((v) {
        leisurePost.add(new LeisurePost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imgId'] = this.imgId;
    data['remark'] = this.remark;
    data['id'] = this.id;
    if (this.serviceStation != null) {
      data['ServiceStation'] =
          this.serviceStation.map((v) => v.toJson()).toList();
    }
    if (this.leisurePost != null) {
      data['LeisurePost'] = this.leisurePost.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceStation {
  String name;
  String remark;
  String id;
  ServiceStation({this.name, this.remark});

  ServiceStation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    remark = json['remark'];
    id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['id'] = this.id;

    return data;
  }
}

class LeisurePost {
  String name;
  String remark;
  String id;

  LeisurePost({this.name, this.remark});

  LeisurePost.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    remark = json['remark'];
    id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['id'] = this.id;

    return data;
  }
}