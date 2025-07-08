
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Auth/Model/LoginModel.dart';
import 'package:saloon_app/Auth/Screens/otp_varification.dart';
import 'package:saloon_app/Common/Common_ShredPrefrence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {

  var loading = false.obs;
  var oldResponse = LoginModel().obs;

  TextEditingController mobileNumberTEC = TextEditingController();

  Future<void> loginCont (MobileNumber) async  {

    try {

      loading(true);

      final newResponse = await ApiServices().login(MobileNumber);
      if(newResponse.responseCode == 1 ){
        oldResponse = newResponse.obs;
        Get.snackbar("OTP", oldResponse.value.data!.otp.toString());
        Get.to( OtpVarificationScreen(userID: oldResponse.value.data!.userId.toString(),));



      }else{
        oldResponse = newResponse.obs;
        Get.snackbar("Login", oldResponse.value.message.toString());
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);

    }finally{
      loading(false);
    }

  }

}