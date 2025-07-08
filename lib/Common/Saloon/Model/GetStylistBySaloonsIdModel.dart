class GetStylistBySaloonsIdModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  GetStylistBySaloonsIdModel(
      {this.success, this.message, this.responseCode, this.data});

  GetStylistBySaloonsIdModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userid;
  int? saloonid;
  String? name;
  String? image;
  String? title;
  String? workingDate;
  String? workingHour;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userid,
        this.saloonid,
        this.name,
        this.image,
        this.title,
        this.workingDate,
        this.workingHour,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    saloonid = json['saloonid'];
    name = json['name'];
    image = json['image'];
    title = json['title'];
    workingDate = json['working_date'];
    workingHour = json['working_hour'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['saloonid'] = this.saloonid;
    data['name'] = this.name;
    data['image'] = this.image;
    data['title'] = this.title;
    data['working_date'] = this.workingDate;
    data['working_hour'] = this.workingHour;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
