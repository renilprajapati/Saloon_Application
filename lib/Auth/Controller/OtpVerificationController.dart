import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Auth/Model/OtpVerificationModel.dart';
import 'package:saloon_app/BottomBar/BottomScreen/BottomBarScreen.dart';
import 'package:saloon_app/Common/Common_ShredPrefrence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationController extends GetxController {
  var loading = false.obs;
  var oldResponse = OtpVerificationModel().obs;

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();

  Future<void> otpVerificationCont (userid, OTP) async  {

    try {

      loading(true);

      final newResponse = await ApiServices().otpVerification(userid, OTP);
      if(newResponse.responseCode == 1 ){
        oldResponse = newResponse.obs;
        Get.snackbar("Login", oldResponse.value.message.toString());


        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setString("userId", oldResponse.value.data!.userDetails!.id.toString());
        sh.setString('userToken', oldResponse.value.data!.token.toString());
        if (kDebugMode) {
          print("userId : ${sh.getString("userId")}");
          print("userToken : ${sh.getString("userToken")}");
        }

        Get.offAll(()=> BottomBarScreen());
      }else{
        oldResponse = newResponse.obs;
        Get.snackbar("OTP verification", oldResponse.value.message.toString());
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);

    }finally{
      loading(false);
    }

  }

}