class BookAppointmentModel {
  bool? success;
  int? responseCode;
  String? message;
  int? id;
  Data? data;

  BookAppointmentModel(
      {this.success, this.responseCode, this.message, this.id, this.data});

  BookAppointmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    responseCode = json['response_code'];
    message = json['message'];
    id = json['id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? saloonId;
  String? stylistId;
  String? userId;
  String? date;
  String? timeSlot;
  String? services;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.saloonId,
        this.stylistId,
        this.userId,
        this.date,
        this.timeSlot,
        this.services,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    saloonId = json['SaloonId'];
    stylistId = json['StylistId'];
    userId = json['UserId'];
    date = json['Date'];
    timeSlot = json['TimeSlot'];
    services = json['Services'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SaloonId'] = this.saloonId;
    data['StylistId'] = this.stylistId;
    data['UserId'] = this.userId;
    data['Date'] = this.date;
    data['TimeSlot'] = this.timeSlot;
    data['Services'] = this.services;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
