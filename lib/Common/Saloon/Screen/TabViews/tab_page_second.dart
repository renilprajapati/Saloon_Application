// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:saloon_app/Common/common_colors.dart';
// import 'package:saloon_app/Saloon/Controller/GetServicesBySaloonIdController.dart';
// import 'package:saloon_app/Saloon/Screen/SaloonDetailsPage.dart';
// import 'package:saloon_app/Textstyles/Textstyles.dart';
//
// class TabPageTwo extends StatefulWidget {
//   String ? saloonId;
//   TabPageTwo({
//     Key? key,
//     required this.saloonId,
//   });
//
//   @override
//   State<TabPageTwo> createState() => _TabPageTwoState();
// }
//
// class _TabPageTwoState extends State<TabPageTwo> {
//
//
//   List selectedServicesList = [];
//   var servicesId ;
//   TabController ? _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     ControllerCalling();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//               () {
//             return _getServicesBySaloonIdCont_obj.loading.value
//                 ?
//             Padding(
//               padding: EdgeInsets.all(Get.width*0.450),
//               child: CircularProgressIndicator(color: common_clr,),
//             )
//                 :
//             _getServicesBySaloonIdCont_obj.allSaloonServicesList.length == 0
//                 ?
//             Padding(
//               padding: EdgeInsets.all(Get.width*0.320),
//               child: const Text("No Services available"),
//             )
//                 :
// // Inside your ListView.builder
//             ListView.builder(
//               physics: const ClampingScrollPhysics(),
//               padding: EdgeInsets.only(top: Get.height * 0.03),
//               itemCount: _getServicesBySaloonIdCont_obj.allSaloonServicesList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 // Extract service details
//                 var service = _getServicesBySaloonIdCont_obj.oldResponse.value.data![index];
//                 // Check if this service is selected
//                 bool isSelected = selectedServicesList.contains(service.id.toString());
//
//                 return Center(
//                   child: SizedBox(
//                     width: Get.width * 0.9,
//                     height: Get.height * 0.07,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               service.name.toString(),
//                               style: FontStyles.w400_24_black,
//                             ),
//                             const Text("15 Minutes",
//                                 style: TextStyle(color: Colors.grey)),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text("Service Fee : ",
//                                 style: TextStyle(color: Colors.grey.shade700)),
//                             Text("\$ 15",
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               // Toggle selection status
//                               if (isSelected) {
//                                 selectedServicesList.remove(service.id.toString());
//                               } else {
//                                 selectedServicesList.add(service.id.toString());
//                               }
//                               print("selectedServicesList :$selectedServicesList");
//                             });
//                           },
//                           child: Container(
//                             width: Get.width * 0.07,
//                             height: Get.height * 0.07,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: isSelected ? Colors.blue : Colors.black,
//                               ),
//                             ),
//                             child: isSelected
//                                 ? Icon(Icons.check, color: Colors.blue)
//                                 : null,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//             ;
//           }
//       ),
//       bottomNavigationBar: InkWell(
//         onTap: () {
//          setState(() {
//            print("hello");
//            Get.to(() => SaloonDetailsPage(
//              saloonId: widget.saloonId, tabBarIndex: 3,
//            ));
//          });
//         },
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: Get.width*0.020),
//           alignment: Alignment.center,
//           width: Get.width * 0.9,
//           height: Get.height * 0.06,
//           decoration: BoxDecoration(
//               border: Border.all(color: common_clr),
//               borderRadius: BorderRadius.circular(15)),
//           child: Text("Next Tab", style: FontStyles.bold_20_commonColor),
//         ),
//       ),
//     );
//   }
//
//   GetServicesBySaloonIdController _getServicesBySaloonIdCont_obj = Get.put(GetServicesBySaloonIdController());
//
//   Future<void> ControllerCalling() async {
//     WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) async{
//       await _getServicesBySaloonIdCont_obj.getServicesBySaloonIdCont(widget.saloonId);
//     });
//   }
// }
