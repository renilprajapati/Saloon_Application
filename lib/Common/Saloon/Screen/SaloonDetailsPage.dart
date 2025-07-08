import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:saloon_app/BottomBar/Home/Controller/GetSaloonByPinCodeController.dart';
import 'package:saloon_app/Common/Saloon/Controller/GetProductBySaloonsIdController.dart';
import 'package:saloon_app/Common/Saloon/Controller/GetSaloonDetailesController.dart';
import 'package:saloon_app/Common/Saloon/Controller/GetServicesBySaloonIdController.dart';
import 'package:saloon_app/Common/Saloon/Controller/GetStylistBySaloonsIdController.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';
import 'package:saloon_app/booking/Controller/BookAppointmentController.dart';
import 'package:saloon_app/booking/Screen/BookAppointmentScreen.dart';

class SaloonDetailsPage extends StatefulWidget {
  String? saloonId;
  String? saloonIdPinCode;
  SaloonDetailsPage({
    super.key,
    required this.saloonId,
    required this.saloonIdPinCode,
  });

  @override
  State<SaloonDetailsPage> createState() => _SaloonDetailsPageState();
}

class _SaloonDetailsPageState extends State<SaloonDetailsPage>
    with SingleTickerProviderStateMixin {
  final GetSaloonDetailesController _getSaloonDetailesCont_obj =
      Get.put(GetSaloonDetailesController());
  final GetSaloonByPinCodeController _getSaloonByPinCodeCont_obj =
      Get.put(GetSaloonByPinCodeController());
  final GetServicesBySaloonIdController _getServicesBySaloonIdCont_obj =
      Get.put(GetServicesBySaloonIdController());
  final GetStylistBySaloonsIdController _getStylistBySaloonsIdCont_obj =
      Get.put(GetStylistBySaloonsIdController());
  final GetProductBySaloonsIdController _getProductBySaloonsIdCont_obj =
      Get.put(GetProductBySaloonsIdController());
  final BookAppointmentController _bookAppointmentCont_obj =
      Get.put(BookAppointmentController());

  List selectedServicesList = [];
  var selectedStylistId;

  Future<void> ControllerCallingFun() async {
    await _getSaloonDetailesCont_obj
        .getSaloonDetailesCont(widget.saloonId)
        .then((value) async {
      await _getSaloonByPinCodeCont_obj
          .getSaloonByPinCodeCont(widget.saloonIdPinCode);
    });
  }

  TabController? _tabController;

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ControllerCallingFun();
    tabNumber = 0;
    print('tabNumber :$tabNumber ');
    _tabController = TabController(length: 4, vsync: this);
  }

  int? tabNumber;
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
                "Saloon Name",
                style: FontStyles.w400_20_white,
              ))),
      body: Obx(() {
        return _getSaloonDetailesCont_obj.loading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: common_clr,
                ),
              )
            : SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),

                        ///============SALOON IMAGE============///
                        tabNumber == 0
                            ? CachedNetworkImage(
                                imageUrl: _getSaloonDetailesCont_obj
                                    .oldResponse.value.data!.image![0]
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                // imageUrl: "https://res.cloudinary.com/dtwqzd4sz/image/upload/v1706524546/dglbnfwykn4sk587bvor.png",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: Get.width * 0.95,
                                  height: Get.height * 0.250,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: common_clr.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) {
                                  return Container(
                                    width: Get.width * 0.95,
                                    height: Get.height * 0.250,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: common_clr),
                                      borderRadius: BorderRadius.circular(10),
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
                                  width: Get.width * 0.95,
                                  height: Get.height * 0.250,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: common_clr),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text("No Image Found"),
                                ),
                              )
                            // Image.asset("assets/images/Rectangle 66.png",width: Get.width*0.95,)
                            : Container(),

                        SizedBox(
                            height: tabNumber == 0
                                ? Get.height * 0.03
                                : Get.height * 0.00),

                        ///====================NAME AND RATINGS======================///
                        SizedBox(
                          width: Get.width * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getSaloonDetailesCont_obj
                                    .oldResponse.value.data!.name
                                    .toString(),
                                style: FontStyles.bold_20_commonColor,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Text(
                                "Hair Saloon",
                                style: FontStyles.w300_15_black,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: 2.75,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.03,
                                  ),
                                  Text(
                                    "4.0",
                                    style: FontStyles.w300_15_black,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Text(
                                    "(225 ratings)",
                                    style: FontStyles.w300_15_black,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        SizedBox(
                          width: Get.width,
                          height: Get.height,
                          child: DefaultTabController(
                            length: 4,
                            child: Column(
                              children: [
                                ///==================== Tabs ======================///
                                TabBar(
                                  controller: _tabController,
                                  physics: const ClampingScrollPhysics(),
                                  // isScrollable: false,
                                  // dragStartBehavior: DragStartBehavior.down,
                                  onTap: (tabNumberx) async {
                                    print("tabNumber :$tabNumberx");
                                    setState(() {
                                      tabNumber = tabNumberx;
                                      print("tabNumber : $tabNumber");
                                      if (tabNumber == 0) {
                                        print("Details page calling ...");
                                      } else if (tabNumber == 1) {
                                        _getServicesBySaloonIdCont_obj
                                            .getServicesBySaloonIdCont(
                                                widget.saloonId);
                                      } else if (tabNumber == 2) {
                                        _getStylistBySaloonsIdCont_obj
                                            .getStylistBySaloonsIdCont(
                                                widget.saloonId);
                                      } else {
                                        _getProductBySaloonsIdCont_obj
                                            .getProductBySaloonsIdCont(
                                                widget.saloonId);
                                      }
                                    });
                                  },
                                  unselectedLabelColor: Colors.grey,
                                  labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  indicatorColor: Colors.green,
                                  tabs: const [
                                    Tab(text: "About"),
                                    Tab(text: "Services"),
                                    Tab(text: "Stylist"),
                                    Tab(text: "Products"),
                                  ],
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    physics: NeverScrollableScrollPhysics(),
                                    clipBehavior: Clip.none,
                                    children: [
                                      ///============================================TAB 1 CONTENT===================================================///
                                      // TabPage1(
                                      //   description: _getSaloonDetailesCont_obj.oldResponse.value.data!.description.toString(),
                                      //   information: '',
                                      //   address: _getSaloonDetailesCont_obj.oldResponse.value.data!.address.toString(),
                                      //   mobileNo: _getSaloonDetailesCont_obj.oldResponse.value.data!.mobile.toString(),
                                      //   pinCode: _getSaloonDetailesCont_obj.oldResponse.value.data!.pincode.toString(),
                                      // ),

                                      SizedBox(
                                        width: Get.width * 0.9,
                                        child: Column(
                                          children: [
                                            Obx(() {
                                              return _getStylistBySaloonsIdCont_obj
                                                      .loading.value
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  Get.height *
                                                                      0.250),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: common_clr,
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      width: Get.width * 0.9,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.030,
                                                          ),
                                                          Text(
                                                            "Description",
                                                            style: FontStyles
                                                                .w700_15_blackbold,
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ),
                                                          Center(
                                                            child: SizedBox(
                                                              width: Get.width *
                                                                  0.9,
                                                              child: Text(
                                                                _getSaloonDetailesCont_obj
                                                                    .oldResponse
                                                                    .value
                                                                    .data!
                                                                    .description
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ),
                                                          Text(
                                                            "Information",
                                                            style: FontStyles
                                                                .w700_15_blackbold,
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ),
                                                          const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Monday - Friday",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              Text(
                                                                "10:00 AM - 11:00 PM",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ),
                                                          const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Saturday - Sunday",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              Text(
                                                                "01:00 PM - 11:00 PM",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                  width:
                                                                      Get.width *
                                                                          0.7,
                                                                  child: Text(_getSaloonDetailesCont_obj
                                                                      .oldResponse
                                                                      .value
                                                                      .data!
                                                                      .address
                                                                      .toString())),
                                                              Container(
                                                                width:
                                                                    Get.width *
                                                                        0.13,
                                                                height:
                                                                    Get.height *
                                                                        0.1,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      common_clr,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    const Icon(
                                                                  CupertinoIcons
                                                                      .location,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const Divider(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                  width:
                                                                      Get.width *
                                                                          0.7,
                                                                  child: Text(_getSaloonDetailesCont_obj
                                                                      .oldResponse
                                                                      .value
                                                                      .data!
                                                                      .mobile
                                                                      .toString())),
                                                              Container(
                                                                width:
                                                                    Get.width *
                                                                        0.13,
                                                                height:
                                                                    Get.height *
                                                                        0.1,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      common_clr,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    const Icon(
                                                                  CupertinoIcons
                                                                      .phone,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                            }),
                                            SizedBox(
                                              height: Get.height * 0.050,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (_tabController!.index <
                                                        3) {
                                                      // Check if the current index is less than the maximum index
                                                      _tabController!.animateTo(
                                                          _tabController!
                                                                  .index +
                                                              1); // Move to the next tab
                                                    }
                                                    _getServicesBySaloonIdCont_obj
                                                        .getServicesBySaloonIdCont(
                                                            widget.saloonId);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: Get.width * 0.9,
                                                    height: Get.height * 0.06,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: common_clr),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Text("Next",
                                                        style: FontStyles
                                                            .bold_20_commonColor),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),

                                      ///=============================================TAB 2 CONTENT==================================================///
                                      // TabPageTwo(saloonId: widget.saloonId,),
                                      SizedBox(
                                        // height: Get.height*0.4,
                                        width: Get.width * 0.9,
                                        // color: Colors.red,
                                        child: Column(
                                          children: [
                                            Obx(() {
                                              return _getServicesBySaloonIdCont_obj
                                                      .loading.value
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  Get.height *
                                                                      0.250),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: common_clr,
                                                      ),
                                                    )
                                                  : _getServicesBySaloonIdCont_obj
                                                              .allSaloonServicesList
                                                              .length ==
                                                          0
                                                      ? Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      Get.height *
                                                                          0.250),
                                                          child: const Text(
                                                              "No Services available"),
                                                        )
                                                      :
                                                      // Inside your ListView.builder
                                                      Container(
                                                          // color: Colors.blueGrey,
                                                          child:
                                                              ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                const ClampingScrollPhysics(),
                                                            padding: EdgeInsets.only(
                                                                top:
                                                                    Get.height *
                                                                        0.03),
                                                            itemCount:
                                                                _getServicesBySaloonIdCont_obj
                                                                    .allSaloonServicesList
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              // Extract service details
                                                              var service =
                                                                  _getServicesBySaloonIdCont_obj
                                                                      .oldResponse
                                                                      .value
                                                                      .data![index];
                                                              // Check if this service is selected
                                                              bool isSelected =
                                                                  selectedServicesList
                                                                      .contains(
                                                                          service
                                                                              .id
                                                                              .toString());

                                                              return Center(
                                                                child: SizedBox(
                                                                  width:
                                                                      Get.width *
                                                                          0.9,
                                                                  height:
                                                                      Get.height *
                                                                          0.07,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            service.name.toString(),
                                                                            style:
                                                                                FontStyles.w400_24_black,
                                                                          ),
                                                                          const Text(
                                                                              "15 Minutes",
                                                                              style: TextStyle(color: Colors.grey)),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                              "Service Fee : ",
                                                                              style: TextStyle(color: Colors.grey.shade700)),
                                                                          const Text(
                                                                              "\$ 15",
                                                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                                                        ],
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            // Toggle selection status
                                                                            if (isSelected) {
                                                                              selectedServicesList.remove(service.id.toString());
                                                                              _bookAppointmentCont_obj.servicesList.remove(service.id.toString());
                                                                            } else {
                                                                              selectedServicesList.add(service.id.toString());
                                                                              _bookAppointmentCont_obj.servicesList.add(service.id.toString());
                                                                            }
                                                                            // print("selectedServicesList :$selectedServicesList");
                                                                            print("selectedServicesList :${_bookAppointmentCont_obj.servicesList}");
                                                                            print("selectedServicesList :${_bookAppointmentCont_obj.servicesList[0].runtimeType}");
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              Get.width * 0.07,
                                                                          height:
                                                                              Get.height * 0.07,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border:
                                                                                Border.all(
                                                                              color: isSelected ? Colors.blue : Colors.black,
                                                                            ),
                                                                          ),
                                                                          child: isSelected
                                                                              ? Icon(Icons.check, color: Colors.blue)
                                                                              : null,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                            }),
                                            SizedBox(
                                              height: Get.height * 0.100,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    print(
                                                        "Total selectedServicesList :${_bookAppointmentCont_obj.servicesList}");

                                                    // Handle Next button tap
                                                    if (selectedServicesList
                                                        .isNotEmpty) {
                                                      if (_tabController!
                                                              .index <
                                                          3) {
                                                        // Check if the current index is less than the maximum index
                                                        _tabController!.animateTo(
                                                            _tabController!
                                                                    .index +
                                                                1); // Move to the next tab
                                                      }
                                                      _getStylistBySaloonsIdCont_obj
                                                          .getStylistBySaloonsIdCont(
                                                              widget.saloonId);
                                                    } else {
                                                      Get.snackbar("Services",
                                                          "Select services");
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: Get.width * 0.9,
                                                    height: Get.height * 0.06,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: common_clr),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Text("Next",
                                                        style: FontStyles
                                                            .bold_20_commonColor),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),

                                      ///=============================================TAB 3 CONTENT==================================================///
                                      // TabPageThree(saloonId: widget.saloonId,),
                                      SizedBox(
                                        height: Get.height,
                                        width: Get.width * 0.9,
                                        child: Column(
                                          children: [
                                            Obx(() {
                                              return _getStylistBySaloonsIdCont_obj
                                                      .loading.value
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  Get.height *
                                                                      0.250),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: common_clr,
                                                      ),
                                                    )
                                                  : _getStylistBySaloonsIdCont_obj
                                                              .allStylistList
                                                              .length ==
                                                          0
                                                      ? Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      Get.height *
                                                                          0.250),
                                                          child: const Text(
                                                              "No Stylist available"),
                                                        )
                                                      : Container(
                                                          // color: Colors.red,
                                                          child: ListView
                                                              .separated(
                                                            shrinkWrap: true,
                                                            physics:
                                                                ClampingScrollPhysics(),
                                                            padding: EdgeInsets.only(
                                                                top:
                                                                    Get.height *
                                                                        0.03),
                                                            itemCount:
                                                                _getStylistBySaloonsIdCont_obj
                                                                    .allStylistList
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    selectedStylistId = _getStylistBySaloonsIdCont_obj
                                                                        .oldResponse
                                                                        .value
                                                                        .data![
                                                                            index]
                                                                        .id
                                                                        .toString();
                                                                    _bookAppointmentCont_obj
                                                                            .stylistId =
                                                                        selectedStylistId
                                                                            .toString();
                                                                    if (kDebugMode) {
                                                                      print(
                                                                          "stylistId = ${_bookAppointmentCont_obj.stylistId}");
                                                                    }
                                                                  });
                                                                },
                                                                child: Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        Get.width *
                                                                            0.9,
                                                                    // height: Get.height * 0.07,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        CachedNetworkImage(
                                                                          imageUrl: _getStylistBySaloonsIdCont_obj
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
                                                                            width:
                                                                                Get.width * 0.16,
                                                                            height:
                                                                                Get.height * 0.080,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              image: DecorationImage(
                                                                                image: imageProvider,
                                                                                fit: BoxFit.cover,
                                                                                // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          placeholder:
                                                                              (context, url) {
                                                                            return Container(
                                                                              width: Get.width * 0.16,
                                                                              height: Get.height * 0.080,
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
                                                                          errorWidget: (context, url, error) =>
                                                                              Container(
                                                                            width:
                                                                                Get.width * 0.16,
                                                                            height:
                                                                                Get.height * 0.080,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              border: Border.all(color: common_clr),
                                                                            ),
                                                                            child:
                                                                                Icon(Icons.error_outline),
                                                                          ),
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              _getStylistBySaloonsIdCont_obj.oldResponse.value.data![index].name.toString(),
                                                                              style: FontStyles.w700_15_blackbold,
                                                                            ),
                                                                            SizedBox(
                                                                              width: Get.width * 0.48,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.star,
                                                                                    color: common_clr,
                                                                                    size: 18,
                                                                                  ),
                                                                                  Text("4.5 ", style: TextStyle(color: Colors.grey)),
                                                                                  Container(
                                                                                    width: Get.width * 0.350,
                                                                                    // color: Colors.red,
                                                                                    child: Text(
                                                                                      _getStylistBySaloonsIdCont_obj.oldResponse.value.data![index].title.toString(),
                                                                                      style: TextStyle(
                                                                                        color: Colors.grey, /*overflow: TextOverflow.ellipsis*/
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              Get.width * 0.07,
                                                                          height:
                                                                              Get.height * 0.07,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border:
                                                                                Border.all(
                                                                              color: selectedStylistId == _getStylistBySaloonsIdCont_obj.oldResponse.value.data![index].id.toString() ? Colors.blue : Colors.black,
                                                                            ),
                                                                          ),
                                                                          child: selectedStylistId == _getStylistBySaloonsIdCont_obj.oldResponse.value.data![index].id.toString()
                                                                              ? Icon(Icons.check, color: Colors.blue)
                                                                              : null,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            separatorBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return const Divider();
                                                            },
                                                          ),
                                                        );
                                            }),
                                            SizedBox(
                                              height: Get.height * 0.100,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // Handle Next button tap
                                                    print(
                                                        "Total selectedServicesList :${_bookAppointmentCont_obj.servicesList}");
                                                    print(
                                                        "Selected stylistId = ${_bookAppointmentCont_obj.stylistId}");

                                                    if (selectedStylistId !=
                                                        null) {
                                                      if (_tabController!
                                                              .index <
                                                          3) {
                                                        // Check if the current index is less than the maximum index
                                                        _tabController!.animateTo(
                                                            _tabController!
                                                                    .index +
                                                                1); // Move to the next tab
                                                      }
                                                      _getProductBySaloonsIdCont_obj
                                                          .getProductBySaloonsIdCont(
                                                              widget.saloonId);
                                                    } else {
                                                      Get.snackbar("Stylist",
                                                          "Select Stylist");
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: Get.width * 0.9,
                                                    height: Get.height * 0.06,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: common_clr),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Text("Next",
                                                        style: FontStyles
                                                            .bold_20_commonColor),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),

                                      ///=============================================TAB 4 CONTENT==================================================///
                                      // TabPageFour(saloonId: widget.saloonId,),

                                      SizedBox(
                                        height: Get.height,
                                        width: Get.width * 0.9,
                                        child: Column(
                                          children: [
                                            Obx(() {
                                              return _getProductBySaloonsIdCont_obj
                                                      .loading.value
                                                  ? Padding(
                                                      padding: EdgeInsets.all(
                                                          Get.width * 0.450),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: common_clr,
                                                      ),
                                                    )
                                                  : _getProductBySaloonsIdCont_obj
                                                              .allProductList
                                                              .length ==
                                                          0
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  Get.width *
                                                                      0.320),
                                                          child: const Text(
                                                              "No Product available"),
                                                        )
                                                      : Center(
                                                          child: Container(
                                                            width:
                                                                Get.width * 0.9,
                                                            child:
                                                                GridView.count(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  ClampingScrollPhysics(),
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: Get.height *
                                                                          0.03),
                                                              childAspectRatio:
                                                                  0.9,
                                                              crossAxisCount: 2,
                                                              crossAxisSpacing:
                                                                  Get.width *
                                                                      0.05,
                                                              mainAxisSpacing:
                                                                  Get.height *
                                                                      0.03,
                                                              children: List.generate(
                                                                  _getProductBySaloonsIdCont_obj
                                                                      .allProductList
                                                                      .length,
                                                                  (index) {
                                                                return Center(
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                              color: Colors.grey,
                                                                              blurRadius: 5.0,
                                                                              spreadRadius: 0.2)
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
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
                                                                            width:
                                                                                Get.width * 0.400,
                                                                            height:
                                                                                Get.height * 0.110,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              image: DecorationImage(
                                                                                image: imageProvider,
                                                                                fit: BoxFit.fitWidth,
                                                                                // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          placeholder:
                                                                              (context, url) {
                                                                            return Container(
                                                                              width: Get.width * 0.400,
                                                                              height: Get.height * 0.110,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(10),
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
                                                                            width:
                                                                                Get.width * 0.400,
                                                                            height:
                                                                                Get.height * 0.110,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              border: Border.all(color: common_clr),
                                                                            ),
                                                                            child:
                                                                                Icon(Icons.error_outline),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height * 0.01,
                                                                        ),
                                                                        SizedBox(
                                                                            width: Get.width *
                                                                                0.4,
                                                                            child:
                                                                                Text(
                                                                              _getProductBySaloonsIdCont_obj.oldResponse.value.data![index].name.toString(),
                                                                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
                                                                            )),
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height * 0.01,
                                                                        ),
                                                                        Text(
                                                                          "\$${_getProductBySaloonsIdCont_obj.oldResponse.value.data![index].price.toString()}",
                                                                          style:
                                                                              FontStyles.w700_15_blackbold,
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
                                            SizedBox(
                                              height: Get.height * 0.100,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    print(
                                                        'saloonId :${widget.saloonId}');
                                                    print(
                                                        "Total selectedServicesList :${_bookAppointmentCont_obj.servicesList}");
                                                    print(
                                                        "Selected stylistId = ${_bookAppointmentCont_obj.stylistId}");
                                                    if (_bookAppointmentCont_obj
                                                                .servicesList ==
                                                            [] ||
                                                        _bookAppointmentCont_obj
                                                                .stylistId ==
                                                            null) {
                                                      Get.snackbar("Required",
                                                          'Fill Remaining Data');
                                                    } else {
                                                      Get.to(() =>
                                                          BookAppointmentScreen(
                                                            saloonId:
                                                                widget.saloonId,
                                                          ));
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: Get.width * 0.9,
                                                    height: Get.height * 0.06,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: common_clr),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Text("Next",
                                                        style: FontStyles
                                                            .bold_20_commonColor),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              );
      }),

      // bottomNavigationBar: InkWell(
      //   onTap: (){
      //     // Get.to(()=>const ReviewBookingScreen());
      //   },
      //   child: Container(
      //     margin: EdgeInsets.symmetric(horizontal: Get.width*0.040, vertical: Get.height*0.020),
      //     alignment: Alignment.center,
      //     width: Get.width*0.9,
      //     height: Get.height*0.06,
      //     decoration: BoxDecoration(
      //       // color: Colors.red,
      //         border: Border.all(color: common_clr),
      //         borderRadius: BorderRadius.circular(15)
      //     ),
      //     child: Text("Book Now",style: FontStyles.bold_20_commonColor,),
      //   ),
      // ),
    );
  }

  // Future<void> ControllerCalling() async {
  //   WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) async{
  //     await _getServicesBySaloonIdCont_obj.getServicesBySaloonIdCont(widget.saloonId);
  //   });
  // }
}
