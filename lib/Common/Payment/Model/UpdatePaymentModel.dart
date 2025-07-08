class UpdatePaymentModel {
  bool? success;
  String? message;
  int? responseCode;
  Data? data;

  UpdatePaymentModel(
      {this.success, this.message, this.responseCode, this.data});

  UpdatePaymentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['response_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['response_code'] = this.responseCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  String? services;
  String? paymentStatus;
  int? orderStatus;
  String? createdAt;
  String? updatedAt;

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
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    saloonId = json['SaloonId'];
    id = json['id'];
    stylistId = json['StylistId'];
    userId = json['UserId'];
    date = json['Date'];
    timeSlot = json['TimeSlot'];
    services = json['Services'];
    paymentStatus = json['PaymentStatus'];
    orderStatus = json['OrderStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SaloonId'] = this.saloonId;
    data['id'] = this.id;
    data['StylistId'] = this.stylistId;
    data['UserId'] = this.userId;
    data['Date'] = this.date;
    data['TimeSlot'] = this.timeSlot;
    data['Services'] = this.services;
    data['PaymentStatus'] = this.paymentStatus;
    data['OrderStatus'] = this.orderStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
