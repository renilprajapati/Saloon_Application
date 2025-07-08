import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Common/PrivacyPolicy/Model/GetPrivacyPolicyModel.dart';

class GetPrivacyPolicyController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetPrivacyPolicyModel().obs;

  Future<void> getTermAndConditionsCont() async {
    try {
      loading(true);

      final newResponse = await ApiServices().getPrivacyPolicy();
      if (newResponse.responseCode == 1) {
        oldResponse = newResponse.obs;
      } else {
        oldResponse = newResponse.obs;
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);
    } finally {
      loading(false);
    }
  }
}
