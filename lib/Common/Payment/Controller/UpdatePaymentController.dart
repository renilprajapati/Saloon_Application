import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/Common/Payment/Model/UpdatePaymentModel.dart';

class UpdatePaymentController extends GetxController {
  var loading = false.obs;
  var oldResponse = UpdatePaymentModel().obs;

  Future<void> updatePaymentCont(appoinmentId) async {
    try {
      loading(true);

      final newResponse = await ApiServices().updatePayment(appoinmentId);
      if (newResponse.responseCode == 1) {
        oldResponse = newResponse.obs;
      } else {
        oldResponse = newResponse.obs;
        Get.snackbar("Payment Status", oldResponse.value.message.toString());
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);
    } finally {
      loading(false);
    }
  }
}
