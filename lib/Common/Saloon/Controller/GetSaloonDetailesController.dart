import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Common/Saloon/Model/GetSaloonDetailesModel.dart';

class GetSaloonDetailesController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetSaloonDetailesModel().obs;

  Future<void> getSaloonDetailesCont(saloonId) async {
    try {
      loading(true);

      final newResponse = await ApiServices().getSaloonDetailes(saloonId);
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
