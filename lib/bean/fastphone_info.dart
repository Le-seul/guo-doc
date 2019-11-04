class FastphoneInfo {
  String clinicNo;
  String clinicName;
  String clinicImage;

  FastphoneInfo({this.clinicNo, this.clinicName, this.clinicImage});

  FastphoneInfo.fromJson(Map<String, dynamic> json) {
    clinicNo = json['clinicNo'];
    clinicName = json['clinicName'];
    clinicImage = json['clinicImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinicNo'] = this.clinicNo;
    data['clinicName'] = this.clinicName;
    data['clinicImage'] = this.clinicImage;
    return data;
  }
}