import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Common/Saloon/Model/GetServicesBySaloonIdModel.dart';

class GetServicesBySaloonIdController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetServicesBySaloonIdModel().obs;

  List allSaloonServicesList = [];

  Future<void> getServicesBySaloonIdCont(saloonId) async {
    try {
      loading(true);

      final newResponse = await ApiServices().getServicesBySaloonId(saloonId);
      if (newResponse.responseCode == 1) {
        oldResponse = newResponse.obs;

        allSaloonServicesList.clear();
        oldResponse.value.data!.forEach((element) {
          allSaloonServicesList.add(element);
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
