class ServCenter {
  String name;
  String imgId;
  String remark;
  bool offstage = true;
  List<ServiceStation> serviceStation;

  ServCenter({this.name, this.imgId, this.remark, this.serviceStation,this.offstage = true});

  ServCenter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imgId = json['imgId'];
    remark = json['remark'];
    if (json['serviceStation'] != null) {
      serviceStation = new List<ServiceStation>();
      json['serviceStation'].forEach((v) {
        serviceStation.add(new ServiceStation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imgId'] = this.imgId;
    data['remark'] = this.remark;
    if (this.serviceStation != null) {
      data['serviceStation'] =
          this.serviceStation.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceStation {
  String name;
  String remark;

  ServiceStation({this.name, this.remark});

  ServiceStation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['remark'] = this.remark;
    return data;
  }
}