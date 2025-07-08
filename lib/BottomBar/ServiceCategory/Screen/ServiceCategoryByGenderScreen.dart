import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/BottomBar/ServiceCategory/Controller/GetServicesCategoryController.dart';
import 'package:saloon_app/Common/Saloon/Screen/SaloonsByCategoryScreen.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';

class ServiceCategoryByGenderScreen extends StatefulWidget {
  String? catogary;
  String? gender;
  ServiceCategoryByGenderScreen(
      {super.key, required this.catogary, required this.gender});

  @override
  State<ServiceCategoryByGenderScreen> createState() =>
      _ServiceCategoryByGenderScreenState();
}

class _ServiceCategoryByGenderScreenState
    extends State<ServiceCategoryByGenderScreen> {
  final GetServicesCategoryController _getServicesCategoryCont_obj =
      Get.put(GetServicesCategoryController());

  final TextEditingController _searchCategoryCTC = TextEditingController();

  List _searchList = [];

  Future<void> controllerCallingFun() async {
    _searchList.clear();
    await _getServicesCategoryCont_obj
        .getServicesCategoryyCont(widget.gender)
        .then((value) {
      _searchList = _getServicesCategoryCont_obj.allCategoryList;
    });
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
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              null,
              Text(
                "Categories",
                style: FontStyles.w400_20_white,
              ))),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: Get.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.0150,
                ),

                Text(
                  '${widget.catogary} Category',
                  style: FontStyles.bold_24_black,
                ),

                ///==================== SEARCH TEXT FORM FIELD ================///

                SizedBox(
                  width: Get.width * 0.9,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      SizedBox(
                        height: Get.height * 0.06,
                        child: TextFormField(
                          controller: _searchCategoryCTC,
                          onChanged: (text) {
                            setState(() {
                              _searchList = _getServicesCategoryCont_obj
                                  .allCategoryList
                                  .where((element) => element.name
                                      .toLowerCase()
                                      .contains(text.toLowerCase()))
                                  .toList();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Search Services...",
                            prefixIcon: const Icon(Icons.search),
                            hintStyle: FontStyles.w400_15_black,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: common_clr)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: common_clr)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: common_clr)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.05,
                ),

                _getServicesCategoryCont_obj.allCategoryList == 0
                    ? Center(child: const Text("No category found"))
                    :

                    ///======================== GRIDVIEW FOR CATEGORY =======================///
                    Obx(() {
                        return _getServicesCategoryCont_obj.loading.value
                            ? SizedBox(
                                width: Get.width * 0.9,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: common_clr,
                                  ),
                                ))
                            : SizedBox(
                                width: Get.width * 0.9,
                                // height: Get.height*0.35,
                                // color: Colors.red,
                                child: GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  childAspectRatio: 0.9,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  shrinkWrap: true,
                                  // children:List.generate(ImageList.length, (index) {
                                  children: List.generate(_searchList.length,
                                      (index) {
                                    // var category = _searchList[index];
                                    return InkWell(
                                      onTap: () {
                                        print(
                                            "category id :${_searchList[index].id.toString()}");
                                        var catID =
                                            _searchList[index].id.toString();
                                        Get.to(SaloonsByCategoryScreen(
                                          categoryId: catID,
                                        ));
                                      },
                                      child: SizedBox(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: _searchList[index]
                                                  .image
                                                  .toString()
                                                  .replaceAll('[', '')
                                                  .replaceAll(']', ''),
                                              // imageUrl: "https://res.cloudinary.com/dtwqzd4sz/image/upload/v1706524546/dglbnfwykn4sk587bvor.png",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: Get.width,
                                                height: Get.height * 0.11,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: common_clr),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.contain,
                                                    // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) {
                                                return Container(
                                                  width: Get.width,
                                                  height: Get.height * 0.11,
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
                                                width: Get.width,
                                                height: Get.height * 0.11,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: common_clr),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text("No Image Found"),
                                              ),
                                            ),
                                            // Container(
                                            //   width: Get.width,
                                            //   height: Get.height*0.11,
                                            //   decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.circular(10),
                                            //       border: Border.all(color: common_clr),
                                            //       image: DecorationImage(image: AssetImage(_searchList[index].image.toString()),fit: BoxFit.fill)
                                            //       // image: DecorationImage(image: AssetImage(ImageList[index].toString()),fit: BoxFit.fill)
                                            //   ),
                                            // ),
                                            Text(
                                              _searchList[index]
                                                  .name
                                                  .toString(),
                                              style:
                                                  FontStyles.w700_15_blackbold,
                                            )
                                            // Text(namesList[index].toString(),style: FontStyles.w700_15_blackbold,)
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> ImageList = [
    "assets/images/Group 8312.png",
    "assets/images/Group 8313.png",
    "assets/images/Group 8314.png",
    "assets/images/Group 8315.png",
    "assets/images/Group 8316.png",
    "assets/images/Group 8317.png",
    "assets/images/Group 8318.png",
    "assets/images/Group 8319.png",
    "assets/images/Group 8320.png",
    "assets/images/Group 8321.png",
  ];

  List<String> namesList = [
    "Hair Cut",
    "Hair Color",
    "Make Up",
    "Hair Spa",
    "Waxing",
    "Facial",
    "Eye Brow",
    "Manicure",
    "Pedicure",
    "Waxing",
  ];
}
