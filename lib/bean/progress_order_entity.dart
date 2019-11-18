class ProgressOrder {
  String id;
  String doctorName;
  String doctorImage;
  String clinicNo;
  String num = '';
  String createTime;
  String type;

  ProgressOrder(
      {this.id,
        this.doctorName,
        this.doctorImage,
        this.clinicNo,
        this.createTime,
        this.num,
        this.type});

  ProgressOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorName = json['doctorName'];
    doctorImage = json['doctorImage'];
    clinicNo = json['clinicNo'];
    createTime = json['createTime'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctorName'] = this.doctorName;
    data['doctorImage'] = this.doctorImage;
    data['clinicNo'] = this.clinicNo;
    data['createTime'] = this.createTime;
    data['type'] = this.type;
    return data;
  }
}