class GetServicesCategoryByGenderModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  GetServicesCategoryByGenderModel(
      {this.success, this.message, this.responseCode, this.data});

  GetServicesCategoryByGenderModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? image;
  String? genderType;
  String? createdAt;
  String? updatedAt;
  String? imagePaths;

  Data(
      {this.id,
        this.name,
        this.image,
        this.genderType,
        this.createdAt,
        this.updatedAt,
        this.imagePaths});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    genderType = json['GenderType'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePaths = json['image_paths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['GenderType'] = this.genderType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_paths'] = this.imagePaths;
    return data;
  }
}
