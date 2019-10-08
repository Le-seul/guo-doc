class User {
	String userName = "张警官";
	String userId;
	String imageUrl = 'http://ygyd.aireading.top/jeecg/api/image.do?getImage&imageId=4';
	String imageUrl2 = 'http://ygyd.aireading.top/jeecg/api/image.do?getImage&imageId=6';

	User({ this.userName,this.userId,this.imageUrl});

	User.fromJson(Map<String, dynamic> json) {
		userName = json['userName'];
		userId = json['userId'];
	}
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userName'] = this.userName;
		data['userId'] = this.userId;
		return data;
	}
}
