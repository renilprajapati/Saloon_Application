class GetBookingHistoryModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  GetBookingHistoryModel(
      {this.success, this.message, this.responseCode, this.data});

  GetBookingHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['response_code'] = this.responseCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? saloonId;
  int? id;
  String? stylistId;
  String? userId;
  String? date;
  String? timeSlot;
  List<Services>? services;
  int? paymentStatus;
  int? orderStatus;
  String? createdAt;
  String? updatedAt;
  int? servicesTotal;
  String? saloonName;

  Data(
      {this.saloonId,
        this.id,
        this.stylistId,
        this.userId,
        this.date,
        this.timeSlot,
        this.services,
        this.paymentStatus,
        this.orderStatus,
        this.createdAt,
        this.updatedAt,
        this.servicesTotal,
        this.saloonName});

  Data.fromJson(Map<String, dynamic> json) {
    saloonId = json['SaloonId'];
    id = json['id'];
    stylistId = json['StylistId'];
    userId = json['UserId'];
    date = json['Date'];
    timeSlot = json['TimeSlot'];
    if (json['Services'] != null) {
      services = <Services>[];
      json['Services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    paymentStatus = json['PaymentStatus'];
    orderStatus = json['OrderStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    servicesTotal = json['ServicesTotal'];
    saloonName = json['SaloonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SaloonId'] = this.saloonId;
    data['id'] = this.id;
    data['StylistId'] = this.stylistId;
    data['UserId'] = this.userId;
    data['Date'] = this.date;
    data['TimeSlot'] = this.timeSlot;
    if (this.services != null) {
      data['Services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['PaymentStatus'] = this.paymentStatus;
    data['OrderStatus'] = this.orderStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['ServicesTotal'] = this.servicesTotal;
    data['SaloonName'] = this.saloonName;
    return data;
  }
}

class Services {
  String? name;
  String? price;
  int? total;

  Services({this.name, this.price, this.total});

  Services.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['total'] = this.total;
    return data;
  }
}
