import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_app/BottomBar/Home/Controller/GetSaloonByPinCodeController.dart';
import 'package:saloon_app/Common/Saloon/Screen/SaloonDetailsPage.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';

class SearchSaloonScreen extends StatefulWidget {
  String? pinCode;
  SearchSaloonScreen({Key? key, required this.pinCode}) : super(key: key);

  @override
  State<SearchSaloonScreen> createState() => _SearchSaloonScreenState();
}

class _SearchSaloonScreenState extends State<SearchSaloonScreen> {
  final GetSaloonByPinCodeController _getSaloonByPinCodeCont_obj =
      Get.put(GetSaloonByPinCodeController());

  final TextEditingController _searchCategoryCTC = TextEditingController();

  List _searchList = [];

  Future<void> controllerCallingFun() async {
    _searchList.clear();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) async {
      await _getSaloonByPinCodeCont_obj
          .getSaloonByPinCodeCont(widget.pinCode.toString())
          .then((value) {
        _searchList = _getSaloonByPinCodeCont_obj.allSaloonList;
        print(_searchList.length);
      });
    });
  }

  @override
  void initState() {
    controllerCallingFun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: common_clr,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
            )),
        title: Text(
          "Search Saloon",
          style: GoogleFonts.mulish(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        actions: [],
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
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
                              _searchList = _getSaloonByPinCodeCont_obj
                                  .allSaloonList
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
                _getSaloonByPinCodeCont_obj.allSaloonList == 0
                    ? const Center(child: Text("No Saloon found"))
                    : _getSaloonByPinCodeCont_obj.loading.value
                        ? SizedBox(
                            height: Get.height * 0.9,
                            width: Get.width * 0.9,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: common_clr,
                              ),
                            ))
                        : Container(
                            margin: EdgeInsets.only(top: 20),
                            height: Get.height * 0.7,
                            width: Get.width * 0.9,
                            // color: Colors.blueGrey,
                            child: SizedBox(
                              width: Get.width * 0.9,
                              height: Get.height,
                              child: ListView.separated(
                                itemCount: _searchList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final actualIndex = index + 1;
                                  return InkWell(
                                    onTap: () {
                                      var saloonId =
                                          _searchList[index].id.toString();
                                      var saloonIdpincode =
                                          _searchList[index].pincode.toString();
                                      //
                                      if (kDebugMode) {
                                        print("saloonId :$saloonId");
                                        print(
                                            "saloonIdpincode :$saloonIdpincode");
                                      }
                                      Get.to(() => SaloonDetailsPage(
                                            saloonId: saloonId,
                                            saloonIdPinCode: saloonIdpincode,
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
                                            imageUrl: _searchList[index]
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
                                              width: Get.width * 0.34,
                                              height: Get.height * 0.14,
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
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.010,
                                              ),
                                              Text(
                                                  _searchList[index]
                                                      .name
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: common_clr)),
                                              SizedBox(
                                                height: Get.height * 0.010,
                                              ),
                                              Container(
                                                  width: Get.width * 0.5,
                                                  // color: Colors.red,
                                                  child: Text(
                                                    _searchList[index]
                                                        .address
                                                        .toString(),
                                                    style: GoogleFonts.mulish(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
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
                          ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
