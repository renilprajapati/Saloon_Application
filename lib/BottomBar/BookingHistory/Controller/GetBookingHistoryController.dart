import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/BottomBar/BookingHistory/Model/GetBookingHistoryModel.dart';

class GetBookingHistoryController extends GetxController {
  var loading = false.obs;
  var oldResponse = GetBookingHistoryModel().obs;

  List allBookingHistoryList = [];
  List allServicesList = [];

  Future<void> getBookingHistoryCont() async {
    try {
      loading(true);

      final newResponse = await ApiServices().getBookingHistory();
      if (newResponse.responseCode == 1) {
        oldResponse = newResponse.obs;
        allBookingHistoryList.clear();
        allServicesList.clear();
        oldResponse.value.data!.forEach((element) {
          allBookingHistoryList.add(element);
        });
      } else {
        oldResponse = newResponse.obs;
        Get.snackbar("Booking History Empty", oldResponse.value.message.toString());
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);
    } finally {
      loading(false);
    }
  }

  Future<void> getBookingHistoryCont1() async {
    try {
      final newResponse = await ApiServices().getBookingHistory();
      if (newResponse.responseCode == 1) {
        oldResponse = newResponse.obs;
        allBookingHistoryList.clear();
        allServicesList.clear();
        oldResponse.value.data!.forEach((element) {
          allBookingHistoryList.add(element);
        });
      } else {
        oldResponse = newResponse.obs;
        Get.snackbar("Booking History", oldResponse.value.message.toString());
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("error :$e");
      }
    }
  }
}
