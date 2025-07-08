import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.08),
          child: CommonAppbar(
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              null,
              Text(
                "Notification",
                style: FontStyles.w400_20_white,
              ))),
      body: ListView.separated(
        padding: EdgeInsets.only(top: Get.height * 0.02),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Container(
              width: Get.width * 0.92,
              height: Get.height * 0.12,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 5.0, spreadRadius: 0.2)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: Get.width * 0.2,
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage("assets/images/Group 8312.png"),
                            fit: BoxFit.fill)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Saloon",
                        style: FontStyles.w700_15_blackbold,
                      ),
                      Text(
                        "Your Booking Appoint...",
                        style: FontStyles.w700_15_blackbold,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: Get.height * 0.03,
          );
        },
      ),
    );
  }
}
