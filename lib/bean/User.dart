class UserInfor {

  String imageId;
  String sex;
  String mobile;
  String userName;


  UserInfor.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    sex = json['sex'];
    mobile = json['mobile'];
    userName = json['userName'];
  }
}