class DoctorInfo {
  String doctorId;
  String name;
  String image;
  String title;
  String levelTitle;
  String clinic;
  String clinicNo;
  String hospital;
  String hospitalGrade;
  String goodAt;

  DoctorInfo(
      {this.doctorId,
        this.name,
        this.image,
        this.title,
        this.levelTitle,
        this.clinic,
        this.clinicNo,
        this.hospital,
        this.hospitalGrade,
        this.goodAt});

  DoctorInfo.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    name = json['name'];
    image = json['image'];
    title = json['title'];
    levelTitle = json['levelTitle'];
    clinic = json['clinic'];
    clinicNo = json['clinicNo'];
    hospital = json['hospital'];
    hospitalGrade = json['hospitalGrade'];
    goodAt = json['goodAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorId'] = this.doctorId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['title'] = this.title;
    data['levelTitle'] = this.levelTitle;
    data['clinic'] = this.clinic;
    data['clinicNo'] = this.clinicNo;
    data['hospital'] = this.hospital;
    data['hospitalGrade'] = this.hospitalGrade;
    data['goodAt'] = this.goodAt;
    return data;
  }
}