import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Common/Saloon/Model/GetSaloonsByCategoryModel.dart';

class GetSaloonsByCategoryController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetSaloonsByCategoryModel().obs;

  List allSaloonList = [];
  List saloonImageList = [];

  Future<void> getSaloonsByCategoryConts(categoryId) async {
    try {
      loading(true);

      final newResponse = await ApiServices().getSaloonsByCategory(categoryId);
      if (newResponse.responseCode == 1) {
        oldResponse = newResponse.obs;

        allSaloonList.clear();
        oldResponse.value.data!.forEach((element) {
          allSaloonList.add(element);
        });

        saloonImageList.clear();
        oldResponse.value.data![0].image!.forEach((element) {
          saloonImageList.add(element);
        });

        print('${oldResponse.value.data![0].toString()}');
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
