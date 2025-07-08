import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Common/PrivacyPolicy/Controller/GetPrivacyPolicyControllerController.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final GetPrivacyPolicyController _getPrivacyPolicyController =
      Get.put(GetPrivacyPolicyController());

  @override
  void initState() {
    _getPrivacyPolicyController.getTermAndConditionsCont();
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
                "Privacy Policy",
                style: FontStyles.w400_20_white,
              ))),
      body: Obx(() {
        return _getPrivacyPolicyController.loading.value
            ? Center(
                child: CircularProgressIndicator(
                color: common_clr,
              ))
            : SingleChildScrollView(
                child: Center(
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: Get.height * 0.020),
                        width: Get.width * 0.9,
                        child: Text(_getPrivacyPolicyController
                            .oldResponse.value.data![0].description
                            .toString()))),
              );
      }),
    );
  }
}
