
import 'package:get/get.dart';
import 'package:saloon_app/ApiServices/ApiServices.dart';
import 'package:saloon_app/BottomBar/BookingHistory/Screen/BookingHistoryScreen.dart';
import 'package:saloon_app/booking/Model/BookAppointmentModel.dart';
import 'package:saloon_app/booking/Screen/ReviewBookingScreen.dart';

class BookAppointmentController extends GetxController {
  var loading = false.obs;
  var oldResponse = BookAppointmentModel().obs;

  String ? saloonID;
  List  servicesList = [];
  String ? stylistId;
  String ? selectedDate;
  String ? timeSlot;

  Future<void>  bookAppointmentCont (saloonID, List servicesList, stylistId, selectedDate, timeSlot,) async  {

    try {

      loading(true);

      final newResponse = await ApiServices().bookAppointment(saloonID, servicesList, stylistId, selectedDate, timeSlot,);
      if(newResponse.success == true ){
        oldResponse = newResponse.obs;
        Get.snackbar("Book Appointment", oldResponse.value.message.toString());
        Get.to(BookingHistoryScreen(route: 'BookAppointmentScreen',));

      }else{
        oldResponse = newResponse.obs;
        Get.snackbar("Book Appointment", oldResponse.value.message.toString());
        if( oldResponse.value.message.toString() == "Date and timeslot not available."){
          Get.to(BookingHistoryScreen(route: 'BookAppointmentScreen',));
        }
      }
    } on Exception catch (e) {
      print("error :$e");
      loading(false);

    }finally{
      loading(false);
    }

  }

}