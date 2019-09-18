class Coursedetail{

  String detailDesc;

  Coursedetail.fromJson(Map<String, dynamic> json) {
    detailDesc = json['detailDesc'];
  }


}