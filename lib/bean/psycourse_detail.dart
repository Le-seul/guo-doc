class PsyCourseDetail{
  String detailDesc;

  PsyCourseDetail.fromJson(Map<String, dynamic> json) {

    detailDesc = json['detailDesc'];

  }

}