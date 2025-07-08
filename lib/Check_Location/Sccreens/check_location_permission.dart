import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_colors.dart';

class CheckLocationPermission extends StatefulWidget {
  const CheckLocationPermission({super.key});

  @override
  State<CheckLocationPermission> createState() =>
      _CheckLocationPermissionState();
}

class _CheckLocationPermissionState extends State<CheckLocationPermission> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: Get.width,
              height: Get.height * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Address-pana 1.png"))),
              // color: Colors.red,
            ),
            Column(
              children: [
                Text(
                  "Enable Location",
                  style: FontStyles.bold_24_black,
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Container(
                    width: Get.width * 0.7,
                    child: Text(
                      "For Letting us know, How much near are you from US",
                      textAlign: TextAlign.center,
                      style: FontStyles.w400_15_black,
                    )),
              ],
            ),
            Container(
              width: Get.width * 0.9,
              height: Get.height * 0.06,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: common_clr)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: common_clr,
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    "Enable Location",
                    style: FontStyles.w700_15_black,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
