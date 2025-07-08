import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_app/BottomBar/BookingHistory/Controller/GetBookingHistoryController.dart';
import 'package:saloon_app/BottomBar/BottomScreen/BottomBarScreen.dart';
import 'package:saloon_app/Common/Payment/Controller/UpdatePaymentController.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/BottomBar/Home/Screen/HomePage.dart';
import 'package:saloon_app/Common/common_colors.dart';

import 'package:saloon_app/booking/Screen/ReviewBookingScreen.dart';

class BookingHistoryScreen extends StatefulWidget {
  String? route;
  String? appoinmentId;
  BookingHistoryScreen({super.key, required this.route, this.appoinmentId});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  final GetBookingHistoryController _getBookingHistoryCont_obj =
      Get.put(GetBookingHistoryController());

  final UpdatePaymentController _updatePaymentCont_obj =
      Get.put(UpdatePaymentController());

  Timer? timer;

  timerFun() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _getBookingHistoryCont_obj.getBookingHistoryCont1();
      });
    });
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      if (widget.route == 'paymentMethodScreen') {
        _updatePaymentCont_obj
            .updatePaymentCont(widget.appoinmentId)
            .then((value) {
          _getBookingHistoryCont_obj.getBookingHistoryCont().then((value) {
            timerFun();
          });
        });
      } else {
        _getBookingHistoryCont_obj.getBookingHistoryCont().then((value) {
          timerFun();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.08),
          child: CommonAppbar(
              widget.route == 'BookAppointmentScreen' ||
                      widget.route == 'paymentMethodScreen'
                  ? InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
              null,
              Text(
                "My Bookings",
                style: FontStyles.w400_20_white,
              ))),
      body: Obx(() {
        return _updatePaymentCont_obj.loading.value
            ? Center(
                child: CircularProgressIndicator(
                color: common_clr,
              ))
            : _getBookingHistoryCont_obj.loading.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: common_clr,
                  ))
                : _getBookingHistoryCont_obj.allBookingHistoryList.length != 0
                    ? ListView.separated(
                        reverse: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: Get.height * 0.03, bottom: Get.height * 0.03),
                        itemCount: _getBookingHistoryCont_obj
                            .allBookingHistoryList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Container(
                              margin:
                                  EdgeInsets.only(bottom: Get.height * 0.020),
                              width: Get.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  border: Border.all(color: common_clr),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              Text(
                                                "Order ID",
                                                style: FontStyles.w300_15_black,
                                              ),
                                              Text(
                                                _getBookingHistoryCont_obj
                                                    .oldResponse
                                                    .value
                                                    .data![index]
                                                    .id
                                                    .toString(),
                                                style: FontStyles.w700_15_grey,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              Text(
                                                "Saloon Name",
                                                style: FontStyles.w300_15_black,
                                              ),
                                              Container(
                                                  width: Get.width * 0.400,
                                                  // color: Colors.red,
                                                  child: Text(
                                                    _getBookingHistoryCont_obj
                                                        .oldResponse
                                                        .value
                                                        .data![index]
                                                        .saloonName
                                                        .toString(),
                                                    style:
                                                        FontStyles.w700_15_grey,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Appointment Date & Time",
                                                style: FontStyles.w300_15_black,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    _getBookingHistoryCont_obj
                                                        .oldResponse
                                                        .value
                                                        .data![index]
                                                        .date
                                                        .toString(),
                                                    style:
                                                        FontStyles.w700_15_grey,
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Text(
                                                    _getBookingHistoryCont_obj
                                                        .oldResponse
                                                        .value
                                                        .data![index]
                                                        .timeSlot
                                                        .toString(),
                                                    style:
                                                        FontStyles.w700_15_grey,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "Selected Services",
                                        style: FontStyles.w300_15_black,
                                      ),
                                      _getBookingHistoryCont_obj
                                                  .allBookingHistoryList[index]
                                                  .services
                                                  .length ==
                                              0
                                          ? const Text("No Servivces Found")
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: Get.height * 0.010),
                                              child: GridView.count(
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                crossAxisCount: 2,
                                                childAspectRatio: 4.5,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10,
                                                children: List.generate(
                                                    _getBookingHistoryCont_obj
                                                        .allBookingHistoryList[
                                                            index]
                                                        .services
                                                        .length, (indexx) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: common_clr),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            Get.width * 0.010),
                                                    child: Text(
                                                      '$indexx : ${_getBookingHistoryCont_obj.allBookingHistoryList[index].services![indexx].name.toString()}',
                                                      style: FontStyles
                                                          .w700_15_grey,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                      SizedBox(
                                        height: Get.height * 0.020,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Total",
                                                        style: FontStyles
                                                            .w300_15_black,
                                                      ),
                                                      Text(
                                                        "Amount  :",
                                                        style: FontStyles
                                                            .w300_15_black,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Text(
                                                    "\$${_getBookingHistoryCont_obj.allBookingHistoryList[index].servicesTotal}",
                                                    style:
                                                        FontStyles.w700_15_grey,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Payment ",
                                                        style: FontStyles
                                                            .w300_15_black,
                                                      ),
                                                      Text(
                                                        "Status  :",
                                                        style: FontStyles
                                                            .w300_15_black,
                                                      ),
                                                    ],
                                                  ),
                                                  _getBookingHistoryCont_obj
                                                              .allBookingHistoryList[
                                                                  index]
                                                              .paymentStatus ==
                                                          0
                                                      ? InkWell(
                                                          onTap: () {
                                                            var apponitMentId =
                                                                _getBookingHistoryCont_obj
                                                                    .allBookingHistoryList[
                                                                        index]
                                                                    .id
                                                                    .toString();
                                                            if (kDebugMode) {
                                                              print(
                                                                  'appointmentId :$apponitMentId');
                                                            }
                                                            Get.to(
                                                                ReviewBookingScreen(
                                                              appointmentId:
                                                                  apponitMentId,
                                                            ));
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: Get.width *
                                                                0.210,
                                                            height: Get.height *
                                                                0.055,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    common_clr,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Text(
                                                                "Pay Now",
                                                                style: GoogleFonts.mulish(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        )
                                                      : Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              Get.width * 0.210,
                                                          height: Get.height *
                                                              0.055,
                                                          decoration:
                                                              BoxDecoration(
                                                                  // color: common_clr,
                                                                  // border: Border.all(color: Colors.black),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                          child: Text("Paid",
                                                              style: GoogleFonts.mulish(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  color: Colors
                                                                      .green)),
                                                        ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.020,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Oder Status : ",
                                              style: GoogleFonts.mulish(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          _getBookingHistoryCont_obj
                                                      .allBookingHistoryList[
                                                          index]
                                                      .orderStatus ==
                                                  0
                                              ? Text("Pending ",
                                                  style: GoogleFonts.mulish(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red))
                                              : _getBookingHistoryCont_obj
                                                          .allBookingHistoryList[
                                                              index]
                                                          .orderStatus ==
                                                      1
                                                  ? Text("Confirm ",
                                                      style: GoogleFonts.mulish(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.green))
                                                  : Text("Cancel ",
                                                      style: GoogleFonts.mulish(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red))
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.020,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: Get.height * 0.02,
                          );
                        },
                      )
                    : const Center(child: Text("No History Found"));
      }),
      floatingActionButton: widget.route == 'BookAppointmentScreen' ||
              widget.route == 'paymentMethodScreen'
          ? InkWell(
              onTap: () {
                Get.offAll(BottomBarScreen());
              },
              child: Container(
                alignment: Alignment.center,
                width: Get.width * 0.9,
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                    color: common_clr,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                child: Text("Continue",
                    style: GoogleFonts.mulish(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            )
          : Container(),
    );
  }
}
