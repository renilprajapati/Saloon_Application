// import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';

import 'package:saloon_app/booking/Screen/ReviewBookingScreen.dart';
import 'package:saloon_app/booking/Controller/BookAppointmentController.dart';

class BookAppointmentScreen extends StatefulWidget {
  String? saloonId;
  BookAppointmentScreen({super.key, required this.saloonId});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final List<String> timeSlots = [
    '10:00 AM To 11:00 AM',
    '11:00 AM To 12:00 PM',
    '12:00 PM To 01:00 PM',
    '01:00 PM To 02:00 PM',
    '02:00 PM To 03:00 PM',
    '03:00 PM To 04:00 PM',
    '04:00 PM To 05:00 PM',
    '05:00 PM To 06:00 PM',
    '06:00 PM To 07:00 PM'
  ];

  final BookAppointmentController _bookAppointmentCont_obj =
      Get.put(BookAppointmentController());

  var selectedTime;
  var selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    selectedTime = '10:00 AM To 11:00 AM';

    _bookAppointmentCont_obj.selectedDate = selectedDate;
    _bookAppointmentCont_obj.timeSlot = selectedTime;

    print("selectedDate :$selectedDate");
    print("selectedTime :$selectedTime");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.08),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: CommonAppbar(
                const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                null,
                Text(
                  "Book Appointment",
                  style: FontStyles.w400_20_white,
                )),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: Get.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///================SELECT DATE AND TIME================///
                // SizedBox(
                //     width: Get.width * 0.9,
                //     // height: Get.height*0.2,
                //     child: EasyDateTimeLine(
                //       initialDate: DateTime.now(),
                //       onDateChange: (date) {
                //         setState(() {
                //           var datex = DateTime(date.year, date.month, date.day);

                //           selectedDate = DateFormat('yyyy-MM-dd').format(datex);
                //           _bookAppointmentCont_obj.selectedDate = selectedDate;
                //           print(
                //               "selectedDate : ${_bookAppointmentCont_obj.selectedDate}");
                //         });
                //       },
                //       activeColor: common_clr,
                //       headerProps: const EasyHeaderProps(
                //         dateFormatter: DateFormatter.monthOnly(),
                //       ),
                //       dayProps: const EasyDayProps(
                //         height: 56.0,
                //         width: 56.0,
                //         dayStructure: DayStructure.dayNumDayStr,
                //         inactiveDayStyle: DayStyle(
                //           borderRadius: 48.0,
                //           dayNumStyle: TextStyle(
                //             fontSize: 18.0,
                //           ),
                //         ),
                //         activeDayStyle: DayStyle(
                //           dayNumStyle: TextStyle(
                //             color: Colors.white,
                //             fontSize: 18.0,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     )),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  "Available Time Slots",
                  style: FontStyles.w400_24_black,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),

                ///====================TIME SLOTS==============///
                GridView.count(
                  childAspectRatio: 2.9,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 15,
                  shrinkWrap: true,
                  children: List.generate(timeSlots.length, (index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedTime = timeSlots[index];
                          _bookAppointmentCont_obj.timeSlot = selectedTime;
                          print(
                              "selectedTime : ${_bookAppointmentCont_obj.timeSlot}");
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: selectedTime == timeSlots[index]
                                ? common_clr
                                : null,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: common_clr)),
                        child: Text(
                          timeSlots[index],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          print('saloonId :${widget.saloonId}');
          print(
              "Total selectedServicesList :${_bookAppointmentCont_obj.servicesList}");
          print(
              "selectedServicesList runtimeType:${_bookAppointmentCont_obj.servicesList[0].runtimeType}");
          print("Selected stylistId = ${_bookAppointmentCont_obj.stylistId}");
          print("selectedDate :${_bookAppointmentCont_obj.selectedDate}");
          print("selectedTime :${_bookAppointmentCont_obj.timeSlot}");

          _bookAppointmentCont_obj.bookAppointmentCont(
            widget.saloonId,
            _bookAppointmentCont_obj.servicesList,
            _bookAppointmentCont_obj.stylistId,
            _bookAppointmentCont_obj.selectedDate,
            _bookAppointmentCont_obj.timeSlot,
          );
        },
        child: Obx(() {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * 0.040, vertical: Get.height * 0.020),
            alignment: Alignment.center,
            width: Get.width * 0.9,
            height: Get.height * 0.06,
            decoration: BoxDecoration(
                // color: Colors.red,
                border: Border.all(color: common_clr),
                borderRadius: BorderRadius.circular(15)),
            child: _bookAppointmentCont_obj.loading.value
                ? CircularProgressIndicator(
                    color: common_clr,
                  )
                : Text(
                    "Book Now",
                    style: FontStyles.bold_20_commonColor,
                  ),
          );
        }),
      ),
    );
  }
}
