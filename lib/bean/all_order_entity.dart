class AllOrder {
  List<TuwenOrder> tuwenOrder = List();
  List<FastphoneOrder> fastphoneOrder = List();

  AllOrder({this.tuwenOrder, this.fastphoneOrder});

  AllOrder.fromJson(Map<String, dynamic> json) {
    if (json['tuwenOrder'] != null) {
      tuwenOrder = new List<TuwenOrder>();
      json['tuwenOrder'].forEach((v) {
        tuwenOrder.add(new TuwenOrder.fromJson(v));
      });
    }
    if (json['fastphoneOrder'] != null) {
      fastphoneOrder = new List<FastphoneOrder>();
      json['fastphoneOrder'].forEach((v) {
        fastphoneOrder.add(new FastphoneOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tuwenOrder != null) {
      data['tuwenOrder'] = this.tuwenOrder.map((v) => v.toJson()).toList();
    }
    if (this.fastphoneOrder != null) {
      data['fastphoneOrder'] =
          this.fastphoneOrder.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TuwenOrder {
  String id;
  String doctorName;
  String doctorImage;
  String createTime;
  String hasAssess;

  TuwenOrder({this.id, this.doctorName, this.doctorImage, this.createTime,this.hasAssess});

  TuwenOrder.fromJson(Map<String, dynamic> json) {
    if(json.containsKey('hasAssess')){
      hasAssess = json['hasAssess'];
    }
    id = json['id'];
    doctorName = json['doctorName'];
    doctorImage = json['doctorImage'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctorName'] = this.doctorName;
    data['doctorImage'] = this.doctorImage;
    data['createTime'] = this.createTime;
    return data;
  }
}

class FastphoneOrder {
  String id;
  String doctorName;
  String doctorImage;
  String clinicNo;
  String createTime;

  FastphoneOrder(
      {this.id,
        this.doctorName,
        this.doctorImage,
        this.clinicNo,
        this.createTime});

  FastphoneOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorName = json['doctorName'];
    doctorImage = json['doctorImage'];
    clinicNo = json['clinicNo'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctorName'] = this.doctorName;
    data['doctorImage'] = this.doctorImage;
    data['clinicNo'] = this.clinicNo;
    data['createTime'] = this.createTime;
    return data;
  }
}