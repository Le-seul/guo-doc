class HistoryOrder {
  String id;
  String doctorName;
  String doctorImage;
  String clinicNo;
  String hasAssess;
  String createTime;
  String type;

  HistoryOrder(
      {this.id,
        this.doctorName,
        this.doctorImage,
        this.clinicNo,
        this.hasAssess,
        this.createTime,
        this.type});

  HistoryOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorName = json['doctorName'];
    doctorImage = json['doctorImage'];
    clinicNo = json['clinicNo'];
    hasAssess = json['hasAssess'];
    createTime = json['createTime'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctorName'] = this.doctorName;
    data['doctorImage'] = this.doctorImage;
    data['clinicNo'] = this.clinicNo;
    data['hasAssess'] = this.hasAssess;
    data['createTime'] = this.createTime;
    data['type'] = this.type;
    return data;
  }
}