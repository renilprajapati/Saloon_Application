
import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/BottomBar/ServiceCategory/Model/GetServicesCategoryByGenderModel.dart';
import 'package:saloon_app/BottomBar/ServiceCategory/Screen/ServiceCategoryByGenderScreen.dart';

class GetServicesCategoryController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetServicesCategoryByGenderModel().obs;

  List allCategoryList = [];

  Future<void> getServicesCategoryyCont(genderType) async  {

    try {
      loading(true);
      final newResponse = await ApiServices().getServicesCategory(genderType);
      if(newResponse.responseCode == 1 ){
        oldResponse = newResponse.obs;
        allCategoryList.clear();
        oldResponse.value.data!.forEach((element) {
          allCategoryList.add(element);
        });
        print("id :${allCategoryList[0].id}");

      }else{
        oldResponse = newResponse.obs;
        Get.snackbar("Services Category", oldResponse.value.message.toString());
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);

    }finally{
      loading(false);
    }

  }

}