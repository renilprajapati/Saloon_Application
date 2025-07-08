import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:saloon_app/Auth/Model/LoginModel.dart';
import 'package:saloon_app/Auth/Model/OtpVerificationModel.dart';
import 'package:saloon_app/Auth/Model/RegisterModel.dart';
import 'package:saloon_app/BottomBar/BookingHistory/Model/GetBookingHistoryModel.dart';
import 'package:saloon_app/BottomBar/Home/Model/GetSaloonByPinCodeModel.dart';
import 'package:saloon_app/BottomBar/ServiceCategory/Model/GetServicesCategoryByGenderModel.dart';
import 'package:saloon_app/BottomBar/ServiceCategory/Model/GetServicesCategoryByGenderModel.dart';
import 'package:saloon_app/Common/Common_BaseUrl.dart';
import 'package:saloon_app/Common/Common_ShredPrefrence.dart';
import 'package:saloon_app/Common/Payment/Model/UpdatePaymentModel.dart';
import 'package:saloon_app/Common/PrivacyPolicy/Model/GetPrivacyPolicyModel.dart';
import 'package:saloon_app/Common/Profile/Model/EditProfileProfileModel.dart';
import 'package:saloon_app/Common/Profile/Model/GetProfileModel.dart';
import 'package:saloon_app/Common/Saloon/Model/GetProductBySaloonsIdModel.dart';
import 'package:saloon_app/Common/Saloon/Model/GetSaloonDetailesModel.dart';
import 'package:saloon_app/Common/Saloon/Model/GetSaloonsByCategoryModel.dart';
import 'package:saloon_app/Common/Saloon/Model/GetServicesBySaloonIdModel.dart';
import 'package:saloon_app/Common/Saloon/Model/GetStylistBySaloonsIdModel.dart';
import 'package:saloon_app/Common/TermsAndCondition/Model/GetTermAndConditionsModel.dart';

import 'package:saloon_app/booking/Model/BookAppointmentModel.dart';
import 'package:saloon_app/booking/Model/GetReviewByAppoinmentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ApiServices {
  Dio dio = Dio(); //variable for api calling

  // Dio dio = Dio()..interceptors.add(PrettyDioLogger(
  //     requestHeader: true,
  //     requestBody: true,
  //     responseBody: true,
  //     responseHeader: false,
  //     error: true,
  //     compact: true,
  //     maxWidth: 90)
  //   );

  ///=====================REGISTER===========================///
  Future<RegisterModel> register(
    FirstName,
    LastName,
    MobileNumber,
    Email,
    Gender,
    BirthDate,
    Pincode,
    Address,
  ) async {
    FormData userForm = FormData();

    userForm.fields.add(MapEntry("First_Name", FirstName));
    userForm.fields.add(MapEntry("Last_Name", LastName));
    userForm.fields.add(MapEntry("Mobile_Number", MobileNumber));
    userForm.fields.add(MapEntry("Email", Email));
    userForm.fields.add(MapEntry("Gender", Gender));
    userForm.fields.add(MapEntry("Birth_Date", BirthDate));
    userForm.fields.add(MapEntry("Pincode", Pincode));
    userForm.fields.add(MapEntry("Address", Address));
    userForm.fields.add(MapEntry("type", "0"));

    final userValue = await dio.post("$baseUrl/register", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = RegisterModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<LoginModel> login(MobileNumber) async {
    FormData userForm = FormData();
    userForm.fields.add(MapEntry("Mobile_Number", MobileNumber));

    final userValue = await dio.post("$baseUrl/login", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = LoginModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<OtpVerificationModel> otpVerification(userid, OTP) async {
    FormData userForm = FormData();
    userForm.fields.add(MapEntry("userid", userid));
    userForm.fields.add(MapEntry("OTP", OTP));

    final userValue = await dio.post("$baseUrl/OTP", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = OtpVerificationModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetSaloonByPinCodeModel> getSaloonByPinCode(pincode) async {
    FormData userForm = FormData();
    userForm.fields.add(MapEntry("pincode", pincode));

    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    print("token $token");

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue =
        await dio.post("$baseUrl/getSaloonsByPincode", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = GetSaloonByPinCodeModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetServicesCategoryByGenderModel> getServicesCategory(
      genderType) async {
    FormData userForm = FormData();
    userForm.fields.add(MapEntry("GenderType", genderType));

    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    print("token $token");

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue = await dio.post("$baseUrl/getCategory", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser =
          GetServicesCategoryByGenderModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetSaloonsByCategoryModel> getSaloonsByCategory(categoryId) async {
    FormData userForm = FormData();
    userForm.fields.add(MapEntry("CategoryId", categoryId));

    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    print("token $token");

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue =
        await dio.post("$baseUrl/getSaloonsByCategory", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = GetSaloonsByCategoryModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetSaloonDetailesModel> getSaloonDetailes(saloonId) async {
    FormData userForm = FormData();
    userForm.fields.add(MapEntry("SaloonID", saloonId));

    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    print("token $token");

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue =
        await dio.post("$baseUrl/getSaloonsDetails", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = GetSaloonDetailesModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetServicesBySaloonIdModel> getServicesBySaloonId(saloonId) async {
    FormData userForm = FormData();
    userForm.fields.add(MapEntry("saloonid", saloonId));

    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    print("token $token");

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue =
        await dio.post("$baseUrl/getServicesBySaloons", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = GetServicesBySaloonIdModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetStylistBySaloonsIdModel> getStylistBySaloonsId(saloonId) async {
    FormData userForm = FormData();
    userForm.fields.add(MapEntry("saloonid", saloonId));

    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    print("token $token");

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue =
        await dio.post("$baseUrl/getStylistBySaloons", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = GetStylistBySaloonsIdModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetProductBySaloonsIdModel> getProductBySaloonsId(saloonId) async {
    FormData userForm = FormData();
    userForm.fields.add(MapEntry("saloonid", saloonId));

    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    print("token $token");

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue =
        await dio.post("$baseUrl/getProductBySaloons", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = GetProductBySaloonsIdModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetTermAndConditionsModel> getTermAndConditions() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    print("token $token");

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue = await dio.get(
      "$baseUrl/getTermCondition",
    );

    if (userValue.statusCode == 200) {
      final valueUser = GetTermAndConditionsModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetPrivacyPolicyModel> getPrivacyPolicy() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    print("token $token");

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue = await dio.get(
      "$baseUrl/getPrivacyPolicy",
    );

    if (userValue.statusCode == 200) {
      final valueUser = GetPrivacyPolicyModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<BookAppointmentModel> bookAppointment(
    saloonID,
    servicesList,
    stylistId,
    selectedDate,
    timeSlot,
  ) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    var useridx = sh.getString('userId');
    print("token $token");

    FormData userForm = FormData();
    userForm.fields.add(MapEntry("UserId", '$useridx'));
    userForm.fields.add(MapEntry("SaloonId", saloonID));
    servicesList.forEach((element) {
      userForm.fields.add(MapEntry("Services[]", element.toString()));
    });
    userForm.fields.add(MapEntry("StylistId", stylistId));
    userForm.fields.add(MapEntry("Date", selectedDate));
    userForm.fields.add(MapEntry("TimeSlot", timeSlot));

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue = await dio.post("$baseUrl/AddAppoinment", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = BookAppointmentModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetReviewByAppoinmentModel> getReviewByAppoinment(
    appoinmentId,
  ) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    print("token $token");

    FormData userForm = FormData();
    userForm.fields.add(MapEntry("AppoinmentId", appoinmentId));

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue =
        await dio.post("$baseUrl/getReviewByAppoinment", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = GetReviewByAppoinmentModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetProfileModel> getProfile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    var userid = sh.getString("userId");
    print("userid $userid");
    print("token $token");

    FormData userForm = FormData();
    userForm.fields.add(MapEntry("UserId", '$userid'));

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue =
        await dio.post("$baseUrl/getProfileByUserId", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = GetProfileModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<EditProfileProfileModel> editProfileProfile(
    firstName,
    lastName,
    mobileNumber,
    email,
    gender,
    birthDate,
    pinCode,
    address,
    profile,
  ) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    var userid = sh.getString("userId");
    print("userid $userid");
    print("token $token");

    FormData userForm = FormData();
    userForm.fields.add(MapEntry("UserId", '$userid'));
    userForm.fields.add(MapEntry("First_Name", '$firstName'));
    userForm.fields.add(MapEntry("Last_Name", '$lastName'));
    userForm.fields.add(MapEntry("Mobile_Number", '$mobileNumber'));
    userForm.fields.add(MapEntry("Email", '$email'));
    userForm.fields.add(MapEntry("Gender", '$gender'));
    userForm.fields.add(MapEntry("Birth_Date", '$birthDate'));
    userForm.fields.add(MapEntry("Pincode", '$pinCode'));
    userForm.fields.add(MapEntry("Address", '$address'));
    userForm.files.add(MapEntry(
        "profile",
        MultipartFile.fromFileSync(profile.path,
            filename: profile.path.split(Platform.pathSeparator).last)));

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue =
        await dio.post("$baseUrl/EditProfileByUserId", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = EditProfileProfileModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<GetBookingHistoryModel> getBookingHistory() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    var userid = sh.getString("userId");
    print("userid $userid");
    print("token $token");

    FormData userForm = FormData();
    userForm.fields.add(MapEntry("UserId", '$userid'));

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue =
        await dio.post("$baseUrl/getAllUserBooking", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = GetBookingHistoryModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }

  Future<UpdatePaymentModel> updatePayment(
    appoinmentId,
  ) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString("userToken");
    print("token $token");

    FormData userForm = FormData();
    userForm.fields.add(MapEntry("AppoinmentId", appoinmentId));

    dio.options.headers['Authorization'] = 'Bearer $token';

    final userValue =
        await dio.post("$baseUrl/UpdatePaymentStatus", data: userForm);

    if (userValue.statusCode == 200) {
      final valueUser = UpdatePaymentModel.fromJson(userValue.data);
      return valueUser;
    }
    throw "Something Went Wrong!!";
  }
}
