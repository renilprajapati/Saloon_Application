import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saloon_app/Common/Payment/Screen/paymentMethodScreen.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';

import 'package:saloon_app/booking/Controller/GetReviewByAppoinmentController.dart';

class ReviewBookingScreen extends StatefulWidget {
  String? appointmentId;
  String? saloonName;
  ReviewBookingScreen({
    super.key,
    required this.appointmentId,
    /* required this.saloonName*/
  });

  @override
  State<ReviewBookingScreen> createState() => _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends State<ReviewBookingScreen> {
  final GetReviewByAppoinmentController _getReviewByAppoinmentCont_obj =
      Get.put(GetReviewByAppoinmentController());

  @override
  void initState() {
    // _getReviewByAppoinmentCont_obj.getReviewByAppoinmentCont(widget.appointmentId);
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      _getReviewByAppoinmentCont_obj
          .getReviewByAppoinmentCont(widget.appointmentId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.08),
          child: CommonAppbar(
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              null,
              Text(
                "Review Booking",
                style: FontStyles.w400_20_white,
              ))),
      body: Obx(() {
        return _getReviewByAppoinmentCont_obj.loading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: common_clr,
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: Get.width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.020,
                        ),

                        ///====================DATE AND TIME===========///
                        Text(
                          "Date & Time",
                          style: FontStyles.w700_20_grey,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Text(
                          _getReviewByAppoinmentCont_obj.formattedDate
                              .toString(),
                          style: FontStyles.w400_24_black,
                        ),
                        Text(
                          _getReviewByAppoinmentCont_obj
                              .oldResponse.value.data!.timeSlot
                              .toString(),
                          style: FontStyles.w700_15_grey,
                        ),
                        const Divider(),

                        ///==================HAIR STYLIST=================///
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getReviewByAppoinmentCont_obj
                                      .oldResponse.value.data!.stylistTitle
                                      .toString(),
                                  style: FontStyles.w700_20_grey,
                                ),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                Text(
                                  _getReviewByAppoinmentCont_obj
                                      .oldResponse.value.data!.stylistName
                                      .toString(),
                                  style: FontStyles.w400_24_black,
                                ),
                                Text(
                                  "Available",
                                  style: FontStyles.w700_15_grey,
                                ),
                              ],
                            ),
                            CachedNetworkImage(
                              imageUrl: _getReviewByAppoinmentCont_obj
                                  .oldResponse.value.data!.stylistImage![0]
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', ''),
                              // imageUrl: "https://res.cloudinary.com/dtwqzd4sz/image/upload/v1706524546/dglbnfwykn4sk587bvor.png",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: Get.height * 0.080,
                                width: Get.width * 0.160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                  ),
                                ),
                              ),
                              placeholder: (context, url) {
                                return Container(
                                  height: Get.height * 0.080,
                                  width: Get.width * 0.160,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: common_clr),
                                  ),
                                  child: CircularProgressIndicator(
                                    color: common_clr,
                                  ),
                                );
                                return CircularProgressIndicator(
                                  color: common_clr,
                                );
                              },
                              errorWidget: (context, url, error) => Container(
                                height: Get.height * 0.080,
                                width: Get.width * 0.160,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: common_clr),
                                ),
                                child: const Icon(Icons.error_outline),
                              ),
                            )
                          ],
                        ),

                        ///======================PAYMENT OPTIONS==================///
                        const Divider(),

                        Text(
                          "Payment Option",
                          style: FontStyles.w700_20_grey,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: Get.width * 0.030),
                              alignment: Alignment.center,
                              width: Get.width * 0.12,
                              height: Get.height * 0.06,
                              decoration: BoxDecoration(
                                  color: common_clr,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(
                                Icons.wallet,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            Text(
                              "Debit/Credit Card",
                              style: FontStyles.w400_24_black,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 27,
                            )
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.010,
                        ),
                        const Divider(),

                        ///======================SERVICES AND TOTAL==================///
                        Text(
                          "Services",
                          style: FontStyles.w700_20_grey,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        _getReviewByAppoinmentCont_obj.allServicesList.length !=
                                0
                            ? ListView.separated(
                                shrinkWrap: true,
                                itemCount: _getReviewByAppoinmentCont_obj
                                    .allServicesList.length,
                                // itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _getReviewByAppoinmentCont_obj
                                            .oldResponse
                                            .value
                                            .data!
                                            .services![index]
                                            .name
                                            .toString(),
                                        style: FontStyles.w400_18_grey,
                                      ),
                                      Text(
                                        "\$${_getReviewByAppoinmentCont_obj.oldResponse.value.data!.services![index].price.toString()}",
                                        style: FontStyles.w400_18_grey,
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: Get.height * 0.010,
                                  );
                                },
                              )
                            : const Text("No services Found "),
                        SizedBox(
                          height: Get.height * 0.020,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                            Text(
                                "\$${_getReviewByAppoinmentCont_obj.oldResponse.value.data!.totalServicesPrice.toString()}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),

                        ///==================APPLY COUPON CODE===============///
                        SizedBox(
                          width: Get.width * 0.9,
                          height: Get.height * 0.06,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Apply Coupon",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                prefixIcon: Icon(
                                  Icons.discount,
                                  color: common_clr,
                                ),
                                suffixIcon: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.3,
                                  height: Get.height * 0.06,
                                  decoration: BoxDecoration(
                                      color: common_clr,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text(
                                    "Apply",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      }),
      bottomNavigationBar: InkWell(
        onTap: () {
          // Get.to(()=> const AddReviewsScreen());
          print("totalPrice:${_getReviewByAppoinmentCont_obj.totalPrice}");
          print("saloonName:${_getReviewByAppoinmentCont_obj.saloonName}");
          if (_getReviewByAppoinmentCont_obj.totalPrice != null &&
              _getReviewByAppoinmentCont_obj.saloonName != null) {
            Get.to(() => paymentMethodScreen(
                  subtotal: _getReviewByAppoinmentCont_obj.totalPrice,
                  SaloonName: _getReviewByAppoinmentCont_obj.saloonName,
                  appoinmentId: _getReviewByAppoinmentCont_obj.appoinmentIdx,
                ));
          }
        },
        child: Container(
          margin: EdgeInsets.all(Get.width * 0.040),
          alignment: Alignment.center,
          width: Get.width * 0.9,
          height: Get.height * 0.06,
          decoration: BoxDecoration(
              // color: Colors.red,
              border: Border.all(color: common_clr),
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            "Confirm",
            style: FontStyles.bold_20_commonColor,
          ),
        ),
      ),
    );
  }
}
