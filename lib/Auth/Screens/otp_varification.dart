import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:saloon_app/Auth/Controller/OtpVerificationController.dart';
import 'package:saloon_app/BottomBar/Home/Controller/LocationController.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_colors.dart';

class OtpVarificationScreen extends StatefulWidget {
  String? userID;
  OtpVarificationScreen({super.key, required this.userID});

  @override
  State<OtpVarificationScreen> createState() => _OtpVarificationScreenState();
}

class _OtpVarificationScreenState extends State<OtpVarificationScreen> {
  final OtpVerificationController _otpVerificationCont_obj =
      Get.put(OtpVerificationController());
  var otp;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: common_clr,
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: common_clr,
      // border: Border.all(color: CupertinoColors.activeBlue),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        // color: CupertinoColors.activeBlue,
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: Get.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.blue,
                  width: Get.width,
                  child: Column(
                    children: [
                      Container(
                        height: Get.height * 0.38,
                        width: Get.width,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/Rectangle-1.png"),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        height: Get.height * 0.5,
                        width: Get.width,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: Get.height * 0.27,
                  child: Container(
                    height: Get.height * 0.45,
                    width: Get.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                                0.5), // Adjust shadow color and opacity
                            offset: const Offset(4, 4), // Adjust shadow offset
                            blurRadius: 8, // Adjust shadow blur radius
                            spreadRadius: 2, // Adjust shadow spread
                          )
                        ]),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.07,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "OTP Verification",
                              style: FontStyles.w400_24_black,
                            )
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Container(
                            width: Get.width * 0.9,
                            child: Text(
                              "We will send you a code please check your Mobile No. and enter your code",
                              textAlign: TextAlign.center,
                              style: FontStyles.w400_15_black,
                            )),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                        Container(
                          width: Get.width * 0.9,
                          height: Get.height * 0.1,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Pinput(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                focusedPinTheme: focusedPinTheme,
                                submittedPinTheme: submittedPinTheme,
                                defaultPinTheme: defaultPinTheme,
                                length: 4,
                                showCursor: true,
                                onChanged: (value) {
                                  otp = value.toString();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: Get.height * 0.65,
                  child: Obx(() {
                    return InkWell(
                      onTap: () {
                        _otpVerificationCont_obj.otpVerificationCont(
                            widget.userID.toString(), otp);
                      },
                      child: Container(
                        width: Get.width * 0.27,
                        height: Get.height * 0.12,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.5), // Adjust shadow color and opacity
                                offset:
                                    const Offset(0, 10), // Adjust shadow offset
                                blurRadius: 8, // Adjust shadow blur radius
                                spreadRadius: 2, // Adjust shadow spread
                              )
                            ]),
                        child: Center(
                          child: Container(
                            width: Get.width * 0.2,
                            height: Get.height * 0.2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: common_clr),
                            child: _otpVerificationCont_obj.loading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.arrow_right_alt,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                          ),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
