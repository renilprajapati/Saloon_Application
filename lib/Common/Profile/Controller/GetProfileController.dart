import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Common/Profile/Controller/EditProfileProfileController.dart';
import 'package:saloon_app/Common/Profile/Model/GetProfileModel.dart';

class GetProfileController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetProfileModel().obs;

  final EditProfileProfileController _editProfileProfileCont_obj =
      Get.put(EditProfileProfileController());

  String? getProfileImage;

  Future<void> getProfileCont() async {
    try {
      loading(true);

      final newResponse = await ApiServices().getProfile();
      if (newResponse.responseCode == 1) {
        oldResponse = newResponse.obs;
        var data = oldResponse.value.data;
        _editProfileProfileCont_obj.firstName.text = data!.firstName.toString();
        _editProfileProfileCont_obj.lastName.text = data!.lastName.toString();
        _editProfileProfileCont_obj.mobileNumber.text =
            data!.mobileNumber.toString();
        _editProfileProfileCont_obj.email.text = data!.email.toString();
        _editProfileProfileCont_obj.gender = data!.gender.toString();
        _editProfileProfileCont_obj.birthDate.text = data!.birthDate.toString();
        _editProfileProfileCont_obj.pinCode.text = data!.pincode.toString();
        _editProfileProfileCont_obj.address.text = data!.address.toString();
        getProfileImage = data!.profile.toString();
      } else {
        oldResponse = newResponse.obs;
        Get.snackbar("Profile", oldResponse.value.message.toString());
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);
    } finally {
      loading(false);
    }
  }
}
