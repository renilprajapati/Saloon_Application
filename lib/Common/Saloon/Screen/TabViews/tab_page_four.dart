import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Common/Saloon/Controller/GetProductBySaloonsIdController.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_colors.dart';

import 'package:saloon_app/booking/Screen/BookAppointmentScreen.dart';

class TabPageFour extends StatefulWidget {
  String? saloonId;
  TabPageFour({Key? key, required this.saloonId});

  @override
  State<TabPageFour> createState() => _TabPageFourState();
}

class _TabPageFourState extends State<TabPageFour> {
  final GetProductBySaloonsIdController _getProductBySaloonsIdCont_obj =
      Get.put(GetProductBySaloonsIdController());

  Future<void> controllerCalingFun() async {
    await _getProductBySaloonsIdCont_obj
        .getProductBySaloonsIdCont(widget.saloonId);
  }

  @override
  void initState() {
    controllerCalingFun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _getProductBySaloonsIdCont_obj.loading.value
            ? Padding(
                padding: EdgeInsets.all(Get.width * 0.450),
                child: CircularProgressIndicator(
                  color: common_clr,
                ),
              )
            : _getProductBySaloonsIdCont_obj.allProductList.length == 0
                ? Padding(
                    padding: EdgeInsets.all(Get.width * 0.320),
                    child: const Text("No Stylist available"),
                  )
                : Center(
                    child: Container(
                      width: Get.width * 0.9,
                      child: GridView.count(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.only(top: Get.height * 0.03),
                        childAspectRatio: 0.9,
                        crossAxisCount: 2,
                        crossAxisSpacing: Get.width * 0.05,
                        mainAxisSpacing: Get.height * 0.03,
                        children: List.generate(
                            _getProductBySaloonsIdCont_obj
                                .allProductList.length, (index) {
                          return Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0,
                                        spreadRadius: 0.2)
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image.asset("assets/images/Rectangle 73.png",),

                                  CachedNetworkImage(
                                    imageUrl: _getProductBySaloonsIdCont_obj
                                        .oldResponse
                                        .value
                                        .data![index]
                                        .image![0]
                                        .toString()
                                        .replaceAll('[', '')
                                        .replaceAll(']', ''),
                                    // imageUrl: "https://res.cloudinary.com/dtwqzd4sz/image/upload/v1706524546/dglbnfwykn4sk587bvor.png",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: Get.width * 0.400,
                                      height: Get.height * 0.110,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitWidth,
                                          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) {
                                      return Container(
                                        width: Get.width * 0.400,
                                        height: Get.height * 0.110,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: Get.width * 0.400,
                                      height: Get.height * 0.110,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: common_clr),
                                      ),
                                      child: Icon(Icons.error_outline),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  SizedBox(
                                      width: Get.width * 0.4,
                                      child: Text(
                                        _getProductBySaloonsIdCont_obj
                                            .oldResponse.value.data![index].name
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Text(
                                    "\$${_getProductBySaloonsIdCont_obj.oldResponse.value.data![index].price.toString()}",
                                    style: FontStyles.w700_15_blackbold,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
      }),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => BookAppointmentScreen(
                    saloonId: widget.saloonId,
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              width: Get.width * 0.9,
              height: Get.height * 0.06,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  border: Border.all(color: common_clr),
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                "Next",
                style: FontStyles.bold_20_commonColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
