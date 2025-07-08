import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:saloon_app/BottomBar/Home/Controller/GetSaloonByPinCodeController.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_colors.dart';

class TabPage1 extends StatefulWidget {
  String? description;
  String? information;
  String? address;
  String? mobileNo;
  String? pinCode;
  TabPage1({
    super.key,
    required this.description,
    required this.information,
    required this.address,
    required this.mobileNo,
    required this.pinCode,
  });

  @override
  State<TabPage1> createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  final GetSaloonByPinCodeController _getSaloonByPinCodeCont_obj =
      Get.put(GetSaloonByPinCodeController());

  Future<void> controllerCallingFun() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      //yourcode
      print("pinCode :${widget.pinCode}");
      await _getSaloonByPinCodeCont_obj
          .getSaloonByPinCodeCont("${widget.pinCode}");
    });
  }

  @override
  void initState() {
    super.initState();
    controllerCallingFun();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Center(
            child: SizedBox(
              width: Get.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.030,
                  ),

                  Text(
                    "Description",
                    style: FontStyles.w700_15_blackbold,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Center(
                    child: SizedBox(
                      width: Get.width * 0.9,
                      child: Text(
                        '${widget.description}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Text(
                    "Information",
                    style: FontStyles.w700_15_blackbold,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Monday - Friday",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "10:00 AM - 11:00 PM",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Saturday - Sunday",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "01:00 PM - 11:00 PM",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: Get.width * 0.7,
                          child: Text("${widget.address}")),
                      Container(
                        width: Get.width * 0.13,
                        height: Get.height * 0.1,
                        decoration: BoxDecoration(
                          color: common_clr,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.location,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: Get.width * 0.7,
                          child: Text("${widget.mobileNo}")),
                      Container(
                        width: Get.width * 0.13,
                        height: Get.height * 0.1,
                        decoration: BoxDecoration(
                          color: common_clr,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.phone,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text("Similar Saloon Nearby",style: FontStyles.w400_24_black,),
                  //     SizedBox(
                  //       child: Row(
                  //         children: [
                  //           Text("See All",style: FontStyles.w700_15_black,),
                  //           Icon(Icons.arrow_forward_ios,color: common_clr,size: 20,),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(height: Get.height*0.02,),
                  // _getSaloonByPinCodeCont_obj.loading.value
                  //     ?
                  // Center(child: CircularProgressIndicator(color: common_clr,))
                  //     :
                  //
                  // ///======================NEARBY SALOON=================///
                  // _getSaloonByPinCodeCont_obj.allSaloonList.length ==0
                  //     ?
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     SizedBox(height: Get.height*0.020,),
                  //     Text("No saloon find near by", style: FontStyles.bold_24_black,),
                  //     SizedBox(height: Get.height*0.100,)
                  //   ],
                  // )
                  //     :
                  // Container(
                  //   width: Get.width,
                  //   height: Get.height*0.3,
                  //   padding: EdgeInsets.symmetric(horizontal: Get.width*0.020),
                  //   child: ListView.separated(
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: _getSaloonByPinCodeCont_obj.allSaloonList.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Center(
                  //         child: InkWell(
                  //           onTap: (){
                  //             var saloonId  = _getSaloonByPinCodeCont_obj.oldResponse.value.data![index].id.toString();
                  //             var saloonIdPinCode  = _getSaloonByPinCodeCont_obj.oldResponse.value.data![index].pincode.toString();
                  //             if (kDebugMode) {
                  //               print("saloonId :$saloonId");
                  //             }
                  //             Get.to(()=> SaloonDetailsPage(saloonId: saloonId, saloonIdPinCode: saloonIdPinCode,));
                  //           },
                  //           child: Container(
                  //             margin: EdgeInsets.symmetric(horizontal: Get.width*0.010),
                  //             width: Get.width*0.8,
                  //             height: Get.height*0.27,
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(15),
                  //                 boxShadow: const [
                  //                   BoxShadow(
                  //                       color: Colors.grey,
                  //                       blurRadius: 5.0,
                  //                       spreadRadius: 0.2
                  //                   )
                  //                 ]
                  //             ),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Container(
                  //                   width: Get.width,
                  //                   height: Get.height*0.19,
                  //                   decoration:  BoxDecoration(
                  //                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  //                       image: DecorationImage(image: NetworkImage(_getSaloonByPinCodeCont_obj.allSaloonList[index].image[0].toString()),fit: BoxFit.fill)
                  //                   ),
                  //                 ),
                  //                 Text("${_getSaloonByPinCodeCont_obj.oldResponse.value.data![index].name}",style: FontStyles.w700_15_blackbold,),
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Text("${_getSaloonByPinCodeCont_obj.oldResponse.value.data![index].address}"),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: SizedBox(
                  //                         child: Row(
                  //                           children: [
                  //                             Icon(CupertinoIcons.location_solid,color: common_clr,),
                  //                             const Text("1.2 KM",style: TextStyle(fontWeight: FontWeight.bold),)
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     separatorBuilder: (BuildContext context, int index) {
                  //       return SizedBox(width: Get.width*0.03,);
                  //     },
                  //
                  //   ),
                  // ),

                  SizedBox(
                    height: Get.height * 0.100,
                  ),
                  // SizedBox(
                  //   width: Get.width,
                  //   height: Get.height*0.3,
                  //   child: ListView.separated(
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: 2,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Center(
                  //         child: InkWell(
                  //           onTap: (){
                  //             // Get.to(()=> const ProductDetailsPage());
                  //           },
                  //           child: Container(
                  //             width: Get.width*0.6,
                  //             height: Get.height*0.23,
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(15),
                  //                 boxShadow: const [
                  //                   BoxShadow(
                  //                       color: Colors.grey,
                  //                       blurRadius: 5.0,
                  //                       spreadRadius: 0.2
                  //                   )
                  //                 ]
                  //             ),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Container(
                  //                   width: Get.width,
                  //                   height: Get.height*0.15,
                  //                   decoration: const BoxDecoration(
                  //                       image: DecorationImage(image: AssetImage("assets/images/nearby.png"),fit: BoxFit.fill)
                  //                   ),
                  //                 ),
                  //                 Text("Friends Unisex Saloon",style: FontStyles.w700_15_blackbold,),
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     const Text("Friends Unisex Saloon"),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: SizedBox(
                  //                         child: Row(
                  //                           children: [
                  //                             Icon(CupertinoIcons.location_solid,color: common_clr,),
                  //                             const Text("1.2 KM",style: TextStyle(fontWeight: FontWeight.bold),)
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     separatorBuilder: (BuildContext context, int index) {
                  //       return SizedBox(width: Get.width*0.03,);
                  //     },
                  //
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
