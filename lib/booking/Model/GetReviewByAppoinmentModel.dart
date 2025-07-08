class GetReviewByAppoinmentModel {
  bool? success;
  String? message;
  int? responseCode;
  Data? data;

  GetReviewByAppoinmentModel(
      {this.success, this.message, this.responseCode, this.data});

  GetReviewByAppoinmentModel.fromJson(Map<String, dynamic> json) {
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
  List<Services>? services;
  int? paymentStatus;
  String? createdAt;
  String? updatedAt;
  int? totalServicesPrice;
  String? saloonName;
  String? stylistName;
  String? stylistTitle;
  String? userName;
  List<String>? stylistImage;

  Data(
      {this.saloonId,
        this.id,
        this.stylistId,
        this.userId,
        this.date,
        this.timeSlot,
        this.services,
        this.paymentStatus,
        this.createdAt,
        this.updatedAt,
        this.totalServicesPrice,
        this.saloonName,
        this.stylistName,
        this.stylistTitle,
        this.userName,
        this.stylistImage});

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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalServicesPrice = json['TotalServicesPrice'];
    saloonName = json['SaloonName'];
    stylistName = json['StylistName'];
    stylistTitle = json['StylistTitle'];
    userName = json['UserName'];
    stylistImage = json['StylistImage'].cast<String>();
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['TotalServicesPrice'] = this.totalServicesPrice;
    data['SaloonName'] = this.saloonName;
    data['StylistName'] = this.stylistName;
    data['StylistTitle'] = this.stylistTitle;
    data['UserName'] = this.userName;
    data['StylistImage'] = this.stylistImage;
    return data;
  }
}

class Services {
  String? name;
  String? price;

  Services({this.name, this.price});

  Services.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
