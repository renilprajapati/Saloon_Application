import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Common/Saloon/Model/GetProductBySaloonsIdModel.dart';

class GetProductBySaloonsIdController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetProductBySaloonsIdModel().obs;

  List allProductList = [];

  Future<void> getProductBySaloonsIdCont(saloonId) async {
    try {
      loading(true);
      final newResponse = await ApiServices().getProductBySaloonsId(saloonId);
      if (newResponse.responseCode == 1) {
        oldResponse = newResponse.obs;
        allProductList.clear();
        oldResponse.value.data!.forEach((element) {
          allProductList.add(element);
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
