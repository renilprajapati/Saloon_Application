import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Common/Profile/Model/EditProfileProfileModel.dart';

class EditProfileProfileController extends GetxController {
  var loading = false.obs;
  var oldResponse = EditProfileProfileModel().obs;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController address = TextEditingController();

  String? gender;

  Future<void> editProfileProfileCont(firstName, lastName, mobileNumber, email,
      gender, birthDate, pinCode, address, profile) async {
    try {
      loading(true);

      final newResponse = await ApiServices().editProfileProfile(
          firstName,
          lastName,
          mobileNumber,
          email,
          gender,
          birthDate,
          pinCode,
          address,
          profile);
      if (newResponse.responseCode == 1) {
        oldResponse = newResponse.obs;
        Get.snackbar("Profile", oldResponse.value.message.toString());
      } else {
        oldResponse = newResponse.obs;
        Get.snackbar("", oldResponse.value.message.toString());
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);
    } finally {
      loading(false);
    }
  }
}
