class EditProfileProfileModel {
  bool? success;
  String? message;
  int? responseCode;
  Data? data;

  EditProfileProfileModel(
      {this.success, this.message, this.responseCode, this.data});

  EditProfileProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  var emailVerifiedAt;
  String? gender;
  String? birthDate;
  String? pincode;
  String? address;
  var oTP;
  String? aadharCard;
  int? type;
  int? status;
  var rememberToken;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobileNumber,
        this.email,
        this.emailVerifiedAt,
        this.gender,
        this.birthDate,
        this.pincode,
        this.address,
        this.oTP,
        this.aadharCard,
        this.type,
        this.status,
        this.rememberToken,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['First_Name'];
    lastName = json['Last_Name'];
    mobileNumber = json['Mobile_Number'];
    email = json['Email'];
    emailVerifiedAt = json['email_verified_at'];
    gender = json['Gender'];
    birthDate = json['Birth_Date'];
    pincode = json['Pincode'];
    address = json['Address'];
    oTP = json['OTP'];
    aadharCard = json['aadhar_card'];
    type = json['type'];
    status = json['status'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['First_Name'] = this.firstName;
    data['Last_Name'] = this.lastName;
    data['Mobile_Number'] = this.mobileNumber;
    data['Email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['Gender'] = this.gender;
    data['Birth_Date'] = this.birthDate;
    data['Pincode'] = this.pincode;
    data['Address'] = this.address;
    data['OTP'] = this.oTP;
    data['aadhar_card'] = this.aadharCard;
    data['type'] = this.type;
    data['status'] = this.status;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
