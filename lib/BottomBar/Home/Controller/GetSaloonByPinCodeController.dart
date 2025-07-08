
import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/BottomBar/Home/Model/GetSaloonByPinCodeModel.dart';

class GetSaloonByPinCodeController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetSaloonByPinCodeModel().obs;

  List allSaloonList = [];

  Future<void> getSaloonByPinCodeCont (pincode) async  {

    try {

      loading(true);

      final newResponse = await ApiServices().getSaloonByPinCode(pincode);
      if(newResponse.responseCode == 1 ){
        oldResponse = newResponse.obs;
        allSaloonList.clear();
        oldResponse.value.data!.forEach((element) {
          allSaloonList.add(element);
        });
        print("image ${allSaloonList[0].image}");

      }else{
        oldResponse = newResponse.obs;
        print("${oldResponse.value.message.toString()}");
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);

    }finally{
      loading(false);
    }

  }

}