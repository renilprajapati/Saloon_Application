import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Common/TermsAndCondition/Controller/GetTermAndConditionsModel.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  final GetTermAndConditionsController _getTermAndConditionsCont_obj =
      Get.put(GetTermAndConditionsController());

  String termsAndConditions = """ """;

  @override
  void initState() {
    _getTermAndConditionsCont_obj.getTermAndConditionsCont();
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
                "Terms And Conditions",
                style: FontStyles.w400_20_white,
              ))),
      body: Obx(() {
        return _getTermAndConditionsCont_obj.loading.value
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
                        child: Text(_getTermAndConditionsCont_obj
                            .oldResponse.value.data![0].description
                            .toString()))),
              );
      }),
    );
  }
}
