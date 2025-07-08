import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Common/Saloon/Controller/GetSaloonsByCategoryModel.dart';
import 'package:saloon_app/Common/Saloon/Screen/SaloonDetailsPage.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';

class SaloonsByCategoryScreen extends StatefulWidget {
  String? categoryId;
  SaloonsByCategoryScreen({super.key, required this.categoryId});

  @override
  State<SaloonsByCategoryScreen> createState() =>
      _SaloonsByCategoryScreenState();
}

class _SaloonsByCategoryScreenState extends State<SaloonsByCategoryScreen> {
  final GetSaloonsByCategoryController _getSaloonsByCategoryCont_obj =
      Get.put(GetSaloonsByCategoryController());

  Future<void> controllerCallingFun() async {
    await _getSaloonsByCategoryCont_obj
        .getSaloonsByCategoryConts(widget.categoryId.toString());
  }

  @override
  void initState() {
    super.initState();
    controllerCallingFun();
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
                "Saloon",
                style: FontStyles.w400_20_white,
              ))),
      body: Obx(() {
        return Center(
          child: _getSaloonsByCategoryCont_obj.loading.value
              ? CircularProgressIndicator(
                  color: common_clr,
                )
              : _getSaloonsByCategoryCont_obj.allSaloonList.length == 0
                  ? const Center(child: Text("No Saloon found"))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Text(
                          "Featured Saloon",
                          style: FontStyles.w400_24_black,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        ///=====================FEATURED SALOON DETAILS====================///
                        InkWell(
                          onTap: () {
                            var saloonId = _getSaloonsByCategoryCont_obj
                                .oldResponse.value.data![0].id
                                .toString();
                            var saloonPincode = _getSaloonsByCategoryCont_obj
                                .oldResponse.value.data![0].pincode
                                .toString();
                            if (kDebugMode) {
                              print("saloonId :$saloonId");
                            }
                            Get.to(() => SaloonDetailsPage(
                                  saloonId: saloonId,
                                  saloonIdPinCode: saloonPincode,
                                ));
                          },
                          child: SizedBox(
                            width: Get.width * 0.9,
                            height: Get.height * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_getSaloonsByCategoryCont_obj.oldResponse.value.data![0].name}",
                                  style: FontStyles.bold_20_commonColor,
                                ),
                                Text(
                                  "${_getSaloonsByCategoryCont_obj.oldResponse.value.data![0].saloonName}",
                                  style: FontStyles.w300_15_black,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "From \$15",
                                      style: FontStyles.w300_15_black,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.05,
                                    ),
                                    // RatingBarIndicator(
                                    //   rating: 2.75,
                                    //   itemBuilder: (context, index) => const Icon(
                                    //     Icons.star,
                                    //     color: Colors.amber,
                                    //   ),
                                    //   itemCount: 5,
                                    //   itemSize: 20.0,
                                    //   direction: Axis.horizontal,
                                    // ),
                                    // SizedBox(width: Get.width*0.05,),
                                    // Text("120",style: FontStyles.w300_15_black,),
                                  ],
                                ),

                                ///===========================IMAGE LISTVIEW================///
                                _getSaloonsByCategoryCont_obj
                                            .saloonImageList.length ==
                                        0
                                    ? Container(
                                        width: Get.width * 0.7,
                                        height: Get.height * 0.19,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: common_clr),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text("No Image Found"),
                                      )
                                    : SizedBox(
                                        width: Get.width,
                                        height: Get.height * 0.2,
                                        // color: Colors.red,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              _getSaloonsByCategoryCont_obj
                                                  .saloonImageList.length,
                                          itemBuilder: (BuildContext context,
                                              int indexx) {
                                            return CachedNetworkImage(
                                              imageUrl:
                                                  _getSaloonsByCategoryCont_obj
                                                      .saloonImageList[indexx]
                                                      .toString()
                                                      .replaceAll('[', '')
                                                      .replaceAll(']', ''),
                                              // imageUrl: "https://res.cloudinary.com/dtwqzd4sz/image/upload/v1706524546/dglbnfwykn4sk587bvor.png",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: Get.width * 0.7,
                                                height: Get.height * 0.19,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) {
                                                return Container(
                                                  width: Get.width * 0.7,
                                                  height: Get.height * 0.19,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: common_clr),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: common_clr,
                                                  ),
                                                );
                                                return CircularProgressIndicator(
                                                  color: common_clr,
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                width: Get.width * 0.7,
                                                height: Get.height * 0.19,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: common_clr),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text("No Image Found"),
                                              ),
                                            );
                                            return Container(
                                              width: Get.width * 0.7,
                                              height: Get.height * 0.19,
                                              // color: Colors.red,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          _getSaloonsByCategoryCont_obj
                                                              .saloonImageList![
                                                                  indexx]
                                                              .toString()
                                                              .replaceAll(
                                                                  '[', '')
                                                              .replaceAll(
                                                                  ']', '')))),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return SizedBox(
                                              width: Get.width * 0.03,
                                            );
                                          },
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "All Saloon",
                          style: FontStyles.w400_24_black,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: Get.width * 0.9,
                            height: Get.height,
                            child: ListView.separated(
                              itemCount: _getSaloonsByCategoryCont_obj
                                      .allSaloonList.length -
                                  1,
                              itemBuilder: (BuildContext context, int index) {
                                final actualIndex = index + 1;
                                return InkWell(
                                  onTap: () {
                                    var saloonId = _getSaloonsByCategoryCont_obj
                                        .oldResponse.value.data![actualIndex].id
                                        .toString();
                                    var saloonPincode =
                                        _getSaloonsByCategoryCont_obj
                                            .oldResponse
                                            .value
                                            .data![actualIndex]
                                            .pincode
                                            .toString();
                                    if (kDebugMode) {
                                      print("saloonId :$saloonId");
                                    }
                                    Get.to(() => SaloonDetailsPage(
                                          saloonId: saloonId,
                                          saloonIdPinCode: saloonPincode,
                                        ));
                                  },
                                  child: SizedBox(
                                    width: Get.width * 0.9,
                                    height: Get.height * 0.15,
                                    // color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              _getSaloonsByCategoryCont_obj
                                                  .oldResponse
                                                  .value
                                                  .data![actualIndex]
                                                  .image![0]
                                                  .toString()
                                                  .replaceAll('[', '')
                                                  .replaceAll(']', ''),
                                          // imageUrl: "https://res.cloudinary.com/dtwqzd4sz/image/upload/v1706524546/dglbnfwykn4sk587bvor.png",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: Get.width * 0.34,
                                            height: Get.height * 0.14,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                                // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) {
                                            return Container(
                                              width: Get.width * 0.34,
                                              height: Get.height * 0.14,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: common_clr),
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                            width: Get.width * 0.34,
                                            height: Get.height * 0.14,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: common_clr),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text("No Image Found"),
                                          ),
                                        ),
                                        // Container(
                                        //   width: Get.width*0.34,
                                        //   height: Get.height*0.14,
                                        //   // color: Colors.black,
                                        //   decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(10),
                                        //     image:const DecorationImage(image: AssetImage("assets/images/Rectangle 61.png"),fit: BoxFit.fill)
                                        //   ),
                                        // ),
                                        SizedBox(
                                          width: Get.width * 0.030,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                                _getSaloonsByCategoryCont_obj
                                                    .oldResponse
                                                    .value
                                                    .data![actualIndex]
                                                    .name
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: common_clr)),
                                            Text(
                                              _getSaloonsByCategoryCont_obj
                                                  .oldResponse
                                                  .value
                                                  .data![actualIndex]
                                                  .saloonName
                                                  .toString(),
                                              style: FontStyles.w300_15_black,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "From \$15",
                                                  style:
                                                      FontStyles.w300_15_black,
                                                ),
                                                // SizedBox(width: Get.width*0.05,),
                                                // RatingBarIndicator(
                                                //   rating: 2.75,
                                                //   itemBuilder: (context, index) =>const Icon(
                                                //     Icons.star,
                                                //     color: Colors.amber,
                                                //   ),
                                                //   itemCount: 5,
                                                //   itemSize: 20.0,
                                                //   direction: Axis.horizontal,
                                                // ),
                                                // // SizedBox(width: Get.width*0.05,),
                                                // Text("120",style: FontStyles.w300_15_black,),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                final actualIndex = index + 1;
                                return SizedBox(
                                  height: Get.height * 0.03,
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
        );
      }),
    );
  }
}
