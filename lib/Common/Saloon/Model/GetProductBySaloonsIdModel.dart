class GetProductBySaloonsIdModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  GetProductBySaloonsIdModel(
      {this.success, this.message, this.responseCode, this.data});

  GetProductBySaloonsIdModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? image;
  String? price;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userid,
        this.saloonid,
        this.name,
        this.image,
        this.price,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    saloonid = json['saloonid'];
    name = json['name'];
    image = json['image'].cast<String>();
    price = json['price'];
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
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
