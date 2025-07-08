import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Auth/Screens/login_ignup_screen.dart';
import 'package:saloon_app/BottomBar/Home/Controller/GetSaloonByPinCodeController.dart';
import 'package:saloon_app/BottomBar/Home/Controller/LocationController.dart';
import 'package:saloon_app/BottomBar/Home/Screen/SearchSaloonScreen.dart';
import 'package:saloon_app/BottomBar/ServiceCategory/Screen/ServiceCategoryByGenderScreen.dart';
import 'package:saloon_app/Common/PrivacyPolicy/Screen/privacy_policy.dart';
import 'package:saloon_app/Common/Profile/Controller/EditProfileProfileController.dart';
import 'package:saloon_app/Common/Profile/Controller/GetProfileController.dart';
import 'package:saloon_app/Common/Profile/Views/my_profile.dart';
import 'package:saloon_app/Common/Saloon/Screen/SaloonDetailsPage.dart';
import 'package:saloon_app/Common/TermsAndCondition/Screen/TermsAndConditionsScreen.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetSaloonByPinCodeController _getSaloonByPinCodeCont_obj =
      Get.put(GetSaloonByPinCodeController());
  final GetProfileController _getProfileCont_obj =
      Get.put(GetProfileController());
  final EditProfileProfileController _editProfileProfileCont_obj =
      Get.put(EditProfileProfileController());

  String pincode = '';
  String cityName = '';

  @override
  void initState() {
    super.initState();
    getPosition();
    _getProfileCont_obj.getProfileCont();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        Future.value(true);
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.08),
            child: CommonAppbar(
                null,
                [
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        CupertinoIcons.bell,
                        color: Colors.white,
                      ))
                ],
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.location_solid,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Text(
                      "$cityName",
                      style: FontStyles.w700_15_white,
                    )
                  ],
                ))),
        body: Obx(() {
          return Container(
            height: Get.height * 0.9,
            // color: Colors.red,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),

                  ///====================SEARCH TEXT FORM FIELD================///
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
                            onTap: () {
                              if (pincode != '') {
                                Get.to(SearchSaloonScreen(
                                  pinCode: '$pincode',
                                ));
                              } else {
                                getPosition();
                              }
                            },
                            readOnly: true,
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
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                      ],
                    ),
                  ),

                  ///===================IMAGE SLIDER======================///
                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.2,
                    child: CarouselSlider(
                      options: CarouselOptions(
                          onPageChanged: (index, reason) =>
                              setState(() => _currentPosition = index),
                          height: Get.height * 0.2,
                          autoPlay: true),
                      items: imageList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  // color: Colors.amber,
                                  image: DecorationImage(
                                      image: AssetImage(i.toString()),
                                      fit: BoxFit.fill)),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),

                  ///=========================SLIDER INDIDCATOR=====================///
                  DotsIndicator(
                    decorator: DotsDecorator(activeColor: common_clr),
                    dotsCount:
                        imageList.length, // Number of dots based on image count
                    position:
                        _currentPosition, // Update this based on slider position
                  ),

                  ///=========================SERVICE CATEGORY TEXT=======================///
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width * 0.13,
                        height: Get.height * 0.06,
                        // color: Colors.red,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/scissors.png"),
                                fit: BoxFit.fill)),
                      ),
                      Text(
                        "Service Category",
                        style: FontStyles.w400_24_black,
                      ),
                      Container(
                        width: Get.width * 0.11,
                        height: Get.height * 0.04,
                        // color: Colors.red,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/flat-iron-svgrepo-com 1.png"),
                                fit: BoxFit.fill)),
                      ),
                    ],
                  ),

                  ///===================CATEGORY GRIDVIEW===============///
                  SizedBox(
                    width: Get.width * 0.9,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 0.8,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      children: List.generate(
                        2,
                        (index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                Get.to(() => ServiceCategoryByGenderScreen(
                                      catogary: 'Men’s',
                                      gender: 'Male',
                                    ));
                              } else {
                                Get.to(() => ServiceCategoryByGenderScreen(
                                      catogary: 'Women’s',
                                      gender: 'Female',
                                    ));
                              }
                              // Get.to(()=>const SaloonsByCategoryScreen());
                            },
                            child: Container(
                              // height: 100,
                              // color: Colors.blueGrey,
                              child: Column(
                                children: [
                                  Container(
                                    height: Get.height * 0.210,
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: common_clr)),
                                    child: Image.asset(
                                        "${genderImageList[index]}"),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.020,
                                  ),
                                  Center(
                                    child: Text(
                                      "${genderCategoryList[index]}",
                                      style: FontStyles.w300_15_black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   width: Get.width * 0.35,
                  //   height: Get.height * 0.05,
                  //   // color: common_clr,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(30),
                  //     border: Border.all(color: common_clr),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "See All",
                  //         style: FontStyles.w700_15_black,
                  //       ),
                  //       Icon(
                  //         Icons.arrow_forward_ios,
                  //         color: common_clr,
                  //         size: 20,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    width: Get.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Near by salon",
                          style: FontStyles.w400_24_black,
                        ),
                        InkWell(
                          onTap: () {
                            print("pinCode; $pincode");
                            if (pincode != '') {
                              Get.to(SearchSaloonScreen(
                                pinCode: '$pincode',
                              ));
                            } else {
                              getPosition();
                            }
                          },
                          child: SizedBox(
                            child: Row(
                              children: [
                                Text(
                                  "All Saloon",
                                  style: FontStyles.w700_15_black,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: common_clr,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),

                  _getSaloonByPinCodeCont_obj.loading.value
                      ? Center(
                          child: CircularProgressIndicator(
                          color: common_clr,
                        ))
                      :

                      ///======================NEARBY SALOON=================///
                      _getSaloonByPinCodeCont_obj.allSaloonList.length == 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.020,
                                ),
                                Text(
                                  "No saloon find near by",
                                  style: FontStyles.bold_24_black,
                                ),
                                SizedBox(
                                  height: Get.height * 0.100,
                                )
                              ],
                            )
                          : Container(
                              width: Get.width,
                              height: Get.height * 0.3,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.020),
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _getSaloonByPinCodeCont_obj
                                    .allSaloonList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(
                                    child: InkWell(
                                      onTap: () {
                                        var saloonId =
                                            _getSaloonByPinCodeCont_obj
                                                .oldResponse
                                                .value
                                                .data![index]
                                                .id
                                                .toString();
                                        var saloonIdPinCode =
                                            _getSaloonByPinCodeCont_obj
                                                .oldResponse
                                                .value
                                                .data![index]
                                                .pincode
                                                .toString();
                                        if (kDebugMode) {
                                          print("saloonId :$saloonId");
                                        }
                                        Get.to(() => SaloonDetailsPage(
                                              saloonId: saloonId,
                                              saloonIdPinCode: saloonIdPinCode,
                                            ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.020),
                                        width: Get.width * 0.8,
                                        // height: Get.height * 0.27,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: common_clr),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 5.0,
                                                  spreadRadius: 0.2)
                                            ]),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: Get.width,
                                              height: Get.height * 0.19,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          _getSaloonByPinCodeCont_obj
                                                              .oldResponse
                                                              .value
                                                              .data![index]
                                                              .image![0]
                                                              .toString()),
                                                      fit: BoxFit.fill)),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.010,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Get.width * 0.010),
                                              // color: Colors.blueGrey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // color: Colors.red,
                                                    width: Get.width * 0.6,
                                                    child: Text(
                                                      "${_getSaloonByPinCodeCont_obj.oldResponse.value.data![index].name}",
                                                      style: FontStyles
                                                          .w700_15_blackbold,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                          // color: Colors.red,
                                                          width:
                                                              Get.width * 0.5,
                                                          child: Text(
                                                            "${_getSaloonByPinCodeCont_obj.oldResponse.value.data![index].address}",
                                                            // "The community has written some articles and packages you might find useful. These articles address flavors for both iOS and Android.",
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                CupertinoIcons
                                                                    .location_solid,
                                                                color:
                                                                    common_clr,
                                                              ),
                                                              const Text(
                                                                "1.2 KM",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    width: Get.width * 0.03,
                                  );
                                },
                              ),
                            ),
                ],
              ),
            ),
          );
        }),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                // <-- SEE HERE
                decoration: BoxDecoration(
                    color: common_clr,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    )),
                accountName: Text(
                  "${_editProfileProfileCont_obj.firstName.text.toString()} ${_editProfileProfileCont_obj.lastName.text.toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  "${_editProfileProfileCont_obj.email.text.toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: CachedNetworkImage(
                  imageUrl: _getProfileCont_obj.getProfileImage
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', ''),
                  // imageUrl: "https://res.cloudinary.com/dtwqzd4sz/image/upload/v1706524546/dglbnfwykn4sk587bvor.png",
                  imageBuilder: (context, imageProvider) => Container(
                    width: Get.width * 0.2,
                    height: Get.height * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                      ),
                    ),
                  ),
                  placeholder: (context, url) {
                    return Container(
                      width: Get.width * 0.2,
                      height: Get.height * 0.1,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                      ),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                    return CircularProgressIndicator(
                      color: common_clr,
                    );
                  },
                  errorWidget: (context, url, error) => Container(
                    width: Get.width * 0.2,
                    height: Get.height * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                    child: const Icon(Icons.error_outline),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: common_clr,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: common_clr,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: common_clr,
                ),
                title: const Text('Edit Profile'),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: common_clr,
                ),
                onTap: () {
                  Get.to(() => const ProfileScreen());
                },
              ),

              // ListTile(
              //   leading: Icon(
              //     Icons.history_edu_outlined,
              //     color: common_clr,
              //   ),
              //   trailing: Icon(
              //     Icons.arrow_forward_ios_outlined,
              //     color: common_clr,
              //   ),
              //   title: const Text('Bookings History'),
              //   onTap: () {},
              // ),

              // ListTile(
              //   leading: Icon(
              //     Icons.lock,
              //     color: common_clr,
              //   ),
              //   trailing: Icon(Icons.arrow_forward_ios_outlined, color: common_clr,),
              //   title: const Text('Change Password'),
              //   onTap: () {
              //     Get.to(() => const ChangePassword());
              //   },
              // ),
              // ListTile(
              //   leading: Icon(
              //     Icons.thumbs_up_down,
              //     color: common_clr,
              //   ),
              //   trailing: Icon(Icons.arrow_forward_ios_outlined, color: common_clr,),
              //
              //   title: const Text('Reviews'),
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              // ),
              ListTile(
                leading: Icon(
                  Icons.branding_watermark_sharp,
                  color: common_clr,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: common_clr,
                ),
                title: const Text('Terms & Condition'),
                onTap: () {
                  Get.to(() => const TermsAndConditionsScreen());
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.privacy_tip,
                  color: common_clr,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: common_clr,
                ),
                title: const Text('Privacy Policy'),
                onTap: () {
                  Get.to(() => const PrivacyPolicy());
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: common_clr,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: common_clr,
                ),
                title: const Text('Logout'),
                onTap: () async {
                  SharedPreferences sh = await SharedPreferences.getInstance();
                  sh.remove("userId");
                  sh.remove("userToken");
                  if (kDebugMode) {
                    print('userId :${sh.getString("userId")}');
                    print('userToken :${sh.getString("userToken")}');
                  }
                  Get.offAll(const loginSignupScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool loadingPosition = false;

  Future<void> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // Call the function to get the address
    await GetAddressFromLatLong(position);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];

    setState(() {
      cityName = '${place.locality}';
      pincode = '${place.postalCode}';
      print("pincode :$pincode");
    });

    if (cityName.isEmpty || pincode.isEmpty) {
      getPosition();
    } else {
      _getSaloonByPinCodeCont_obj.getSaloonByPinCodeCont(pincode.toString());
    }
  }

  List<String> imageList = [
    'assets/images/Frame 1.png',
    'assets/images/Frame 1.png',
    'assets/images/Frame 1.png',
  ];

  List genderImageList = [
    'assets/images/beautiful-skin-man-svgrepo-com 1.png',
    'assets/images/woman-with-beautiful-skin-svgrepo-com 1.png'
  ];
  List genderCategoryList = ['Men’s', 'Women’s'];

  int _currentPosition = 0;

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
