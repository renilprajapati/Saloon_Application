import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Common/Saloon/Model/GetStylistBySaloonsIdModel.dart';

class GetStylistBySaloonsIdController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetStylistBySaloonsIdModel().obs;

  List allStylistList = [];

  Future<void> getStylistBySaloonsIdCont(saloonId) async {
    try {
      loading(true);

      final newResponse = await ApiServices().getStylistBySaloonsId(saloonId);
      if (newResponse.responseCode == 1) {
        oldResponse = newResponse.obs;

        allStylistList.clear();
        oldResponse.value.data!.forEach((element) {
          allStylistList.add(element);
        });
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
