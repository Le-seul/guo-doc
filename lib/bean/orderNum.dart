class OrderNum {
  String location;
  String orderId;
  String num;
  int id;

  OrderNum({this.location, this.orderId,this.num,this.id});

  OrderNum.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    orderId = json['orderId'];
    num = json['num'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['orderId'] = this.orderId;
    return data;
  }
  OrderNum.fromMap(Map<String, dynamic> map) {
    orderId = map['orderId'];
    location = map['location'];
    num = map['num'];
    id = map['id'];
  }

}