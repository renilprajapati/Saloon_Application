import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Common/TermsAndCondition/Model/GetTermAndConditionsModel.dart';

class GetTermAndConditionsController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetTermAndConditionsModel().obs;

  String? description;
  Future<void> getTermAndConditionsCont() async {
    try {
      loading(true);

      final newResponse = await ApiServices().getTermAndConditions();
      if (newResponse.responseCode == 1) {
        oldResponse = newResponse.obs;
        oldResponse.value.data!.forEach((element) {
          description = element.description.toString();
        });
        print("description : ${description}");
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
