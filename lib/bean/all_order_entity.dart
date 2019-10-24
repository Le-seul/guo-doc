class AllOrder {
  List<FastphoneOrder> fastphoneOrder;
  List<TuwenOrder> tuwenOrder;

  AllOrder({this.fastphoneOrder, this.tuwenOrder});

  AllOrder.fromJson(Map<String, dynamic> json) {
    if (json['FastphoneOrder'] != null) {
      fastphoneOrder = new List<FastphoneOrder>();
      json['FastphoneOrder'].forEach((v) {
        fastphoneOrder.add(new FastphoneOrder.fromJson(v));
      });
    }
    if (json['TuwenOrder'] != null) {
      tuwenOrder = new List<TuwenOrder>();
      json['TuwenOrder'].forEach((v) {
        tuwenOrder.add(new TuwenOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fastphoneOrder != null) {
      data['FastphoneOrder'] =
          this.fastphoneOrder.map((v) => v.toJson()).toList();
    }
    if (this.tuwenOrder != null) {
      data['TuwenOrder'] = this.tuwenOrder.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FastphoneOrder {
  String phone;
  String createTime;
  String clinicNo;
  String serviceId;
  String partnerOrderId;

  FastphoneOrder(
      {this.phone,
        this.createTime,
        this.clinicNo,
        this.serviceId,
        this.partnerOrderId});

  FastphoneOrder.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    createTime = json['createTime'];
    clinicNo = json['clinicNo'];
    serviceId = json['serviceId'];
    partnerOrderId = json['partnerOrderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['createTime'] = this.createTime;
    data['clinicNo'] = this.clinicNo;
    data['serviceId'] = this.serviceId;
    data['partnerOrderId'] = this.partnerOrderId;
    return data;
  }
}

class TuwenOrder {
  String doctorId;
  String createTime;
  String problemId;
  String interactionCount;
  String partnerOrderId;

  TuwenOrder(
      {this.doctorId,
        this.createTime,
        this.problemId,
        this.interactionCount,
        this.partnerOrderId});

  TuwenOrder.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    createTime = json['createTime'];
    problemId = json['problemId'];
    interactionCount = json['interactionCount'];
    partnerOrderId = json['partnerOrderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorId'] = this.doctorId;
    data['createTime'] = this.createTime;
    data['problemId'] = this.problemId;
    data['interactionCount'] = this.interactionCount;
    data['partnerOrderId'] = this.partnerOrderId;
    return data;
  }
}