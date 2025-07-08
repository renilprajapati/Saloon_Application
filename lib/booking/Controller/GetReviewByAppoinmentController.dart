
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/booking/Model/GetReviewByAppoinmentModel.dart';

class GetReviewByAppoinmentController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetReviewByAppoinmentModel().obs;

  String ?formattedDate;
  List allServicesList = [];
  double? totalPrice;
  String? saloonName;
  String? appoinmentIdx;


  Future<void> getReviewByAppoinmentCont (appoinmentId) async  {

    try {

      loading(true);

      final newResponse = await ApiServices().getReviewByAppoinment(appoinmentId);
      if(newResponse.responseCode == 1 ){
        oldResponse = newResponse.obs;
        dateConvertFun(oldResponse.value.data!.date.toString());
        allServicesList.clear();
        oldResponse.value.data!.services!.forEach((element) {
          allServicesList.add(element.name.toString());
        });
        totalPrice = double.parse(oldResponse.value.data!.totalServicesPrice.toString());
        saloonName = oldResponse.value.data!.saloonName.toString();
        appoinmentIdx = oldResponse.value.data!.id.toString();
        print('appoinmentId :$appoinmentIdx');

      }else{
        oldResponse = newResponse.obs;
        Get.snackbar("", oldResponse.value.message.toString());
        Get.back();
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);

    }finally{
      loading(false);
    }

  }


  Future<void> dateConvertFun(datex) async {
    String inputDateStr = '$datex';
    DateTime inputDate = DateTime.parse(inputDateStr);
    // Format the date
    formattedDate = DateFormat('EEEE, MMMM dd').format(inputDate);
    if (kDebugMode) {
      print("formattedDate :$formattedDate");
    }

  }

}