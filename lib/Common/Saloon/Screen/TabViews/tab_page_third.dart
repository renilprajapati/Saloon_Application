// import 'dart:async';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:saloon_app/Common/common_colors.dart';
// import 'package:saloon_app/Saloon/Controller/GetStylistBySaloonsIdController.dart';
// import 'package:saloon_app/Textstyles/Textstyles.dart';
//
// class TabPageThree extends StatefulWidget {
//   String? saloonId;
//   TabPageThree({
//     Key? key,
//     required this.saloonId
//   });
//
//   @override
//   State<TabPageThree> createState() => _TabPageThreeState();
// }
//
// class _TabPageThreeState extends State<TabPageThree> {
//
//   final GetStylistBySaloonsIdController _getStylistBySaloonsIdCont_obj = Get.put(GetStylistBySaloonsIdController());
//   int ? _selectedIndex;
//
//   Future<void> controllerCalingFun () async {
//     await _getStylistBySaloonsIdCont_obj.getStylistBySaloonsIdCont(widget.saloonId);
//   }
//
//   @override
//   void initState() {
//     controllerCalingFun();
//     super.initState();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//          () {
//           return _getStylistBySaloonsIdCont_obj.loading.value
//               ?
//           Padding(
//             padding: EdgeInsets.all(Get.width*0.450),
//             child: CircularProgressIndicator(color: common_clr,),
//           )
//               :
//           _getStylistBySaloonsIdCont_obj.allStylistList.length == 0
//               ?
//           Padding(
//             padding: EdgeInsets.all(Get.width*0.320),
//             child: const Text("No Stylist available"),
//           )
//               :
//           ListView.separated(
//             physics: ClampingScrollPhysics(),
//             padding: EdgeInsets.only(top: Get.height * 0.03),
//             itemCount: _getStylistBySaloonsIdCont_obj.allStylistList.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Center(
//                 child: SizedBox(
//                   width: Get.width * 0.9,
//                   // height: Get.height * 0.07,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//
//                       CachedNetworkImage(
//                         imageUrl: _getStylistBySaloonsIdCont_obj.oldResponse.value.data![index].image![0].toString().replaceAll('[', '').replaceAll(']', ''),
//                         // imageUrl: "https://res.cloudinary.com/dtwqzd4sz/image/upload/v1706524546/dglbnfwykn4sk587bvor.png",
//                         imageBuilder: (context, imageProvider) => Container(
//                           width: Get.width * 0.16,
//                           height: Get.height*0.080,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                               image: imageProvider,
//                               fit: BoxFit.cover,
//                               // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
//                             ),
//                           ),
//                         ),
//                         placeholder: (context, url){
//                           return Container(
//                             width: Get.width * 0.16,
//                             height: Get.height*0.080,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(color: common_clr),
//                             ),
//                             child: CircularProgressIndicator(color: common_clr,),
//                           );
//                           return CircularProgressIndicator(color: common_clr,);
//                         },
//                         errorWidget: (context, url, error) => Container(
//                           width: Get.width * 0.16,
//                           height: Get.height*0.080,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(color: common_clr),
//                           ),
//                           child: Icon(Icons.error_outline),
//                         ),
//                       ),
//
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             _getStylistBySaloonsIdCont_obj.oldResponse.value.data![index].name.toString(),
//                             style: FontStyles.w700_15_blackbold,
//                           ),
//                           SizedBox(
//                             width: Get.width * 0.48,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Icon(Icons.star, color: common_clr, size: 18,),
//                                 Text("4.5 ", style: TextStyle(color: Colors.grey)),
//                                 Container(
//                                   width: Get.width*0.350,
//                                   // color: Colors.red,
//                                   child: Text(
//                                     _getStylistBySaloonsIdCont_obj.oldResponse.value.data![index].title.toString(),
//                                     style: TextStyle(color: Colors.grey, /*overflow: TextOverflow.ellipsis*/),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _selectedIndex = index;
//                           });
//                         },
//                         child: Container(
//                           width: Get.width * 0.07,
//                           height: Get.height * 0.07,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: _selectedIndex == index ? Colors.blue : Colors.black,
//                             ),
//                           ),
//                           child: _selectedIndex == index
//                               ? Icon(Icons.check, color: Colors.blue)
//                               : null,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//             separatorBuilder: (BuildContext context, int index) {
//               return const Divider();
//             },
//           );
//         }
//       ),
//       bottomNavigationBar: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           InkWell(
//             onTap: () {
//               // Handle Next button tap
//             },
//             child: Container(
//               alignment: Alignment.center,
//               width: Get.width * 0.9,
//               height: Get.height * 0.06,
//               decoration: BoxDecoration(
//                 border: Border.all(color: common_clr),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Text("Next", style: FontStyles.bold_20_commonColor),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
