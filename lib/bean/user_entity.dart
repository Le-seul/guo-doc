class User {
	String userName;
	String userId;

	User({ this.userName});

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
