import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Auth/Model/RegisterModel.dart';
import 'package:saloon_app/BottomBar/BottomScreen/BottomBarScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  var loading = false.obs;
  var oldResponse = RegisterModel().obs;

  TextEditingController firstNameCTC = TextEditingController();
  TextEditingController lastNameCTC = TextEditingController();
  TextEditingController mobileNumberCTC = TextEditingController();
  TextEditingController emailCTC = TextEditingController();
  TextEditingController genderCTC = TextEditingController();
  TextEditingController birthDateCTC = TextEditingController();
  TextEditingController pincodeCTC = TextEditingController();
  TextEditingController addressCTC = TextEditingController();

  Future<void> registerCont (FirstName, LastName, MobileNumber, Email, Gender, BirthDate, Pincode, Address, ) async  {

    try {

      loading(true);

      final newResponse = await ApiServices().register(FirstName, LastName, MobileNumber, Email, Gender, BirthDate, Pincode, Address,);
      if(newResponse.success == true ){
        oldResponse = newResponse.obs;
        Get.snackbar("SignUp", oldResponse.value.message.toString());
        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setString("userId", oldResponse.value.user!.id.toString());
        sh.setString('userToken', oldResponse.value.token.toString());
        if (kDebugMode) {
          print("userId : ${sh.getString("userId")}");
          print("userToken : ${sh.getString("userToken")}");
        }
        Get.offAll(()=> BottomBarScreen());
      }else{
        oldResponse = newResponse.obs;
        Get.snackbar("SignUp", oldResponse.value.message.toString());
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);

    }finally{
      loading(false);
    }

  }

}