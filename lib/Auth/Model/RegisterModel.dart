class RegisterModel {
  bool? success;
  User? user;
  String? token;
  String? message;

  RegisterModel({this.success, this.user, this.token, this.message});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}

class User {
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? gender;
  String? birthDate;
  String? pincode;
  String? address;
  String? type;
  int? status;
  Null? aadharCard;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.firstName,
        this.lastName,
        this.mobileNumber,
        this.email,
        this.gender,
        this.birthDate,
        this.pincode,
        this.address,
        this.type,
        this.status,
        this.aadharCard,
        this.updatedAt,
        this.createdAt,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['First_Name'];
    lastName = json['Last_Name'];
    mobileNumber = json['Mobile_Number'];
    email = json['Email'];
    gender = json['Gender'];
    birthDate = json['Birth_Date'];
    pincode = json['Pincode'];
    address = json['Address'];
    type = json['type'];
    status = json['status'];
    aadharCard = json['aadhar_card'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['First_Name'] = this.firstName;
    data['Last_Name'] = this.lastName;
    data['Mobile_Number'] = this.mobileNumber;
    data['Email'] = this.email;
    data['Gender'] = this.gender;
    data['Birth_Date'] = this.birthDate;
    data['Pincode'] = this.pincode;
    data['Address'] = this.address;
    data['type'] = this.type;
    data['status'] = this.status;
    data['aadhar_card'] = this.aadharCard;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
