class GetServicesBySaloonIdModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  GetServicesBySaloonIdModel(
      {this.success, this.message, this.responseCode, this.data});

  GetServicesBySaloonIdModel.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? price;
  String? stylist;
  String? product;
  String? genderType;
  String? category;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userid,
        this.saloonid,
        this.name,
        this.image,
        this.description,
        this.price,
        this.stylist,
        this.product,
        this.genderType,
        this.category,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    saloonid = json['saloonid'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    stylist = json['Stylist'];
    product = json['Product'];
    genderType = json['GenderType'];
    category = json['Category'];
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
    data['description'] = this.description;
    data['price'] = this.price;
    data['Stylist'] = this.stylist;
    data['Product'] = this.product;
    data['GenderType'] = this.genderType;
    data['Category'] = this.category;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
