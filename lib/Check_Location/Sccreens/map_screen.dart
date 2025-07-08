import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Common/common_appbar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize:Size.fromHeight(Get.height*0.08),
      child: CommonAppbar(
          Icon(Icons.arrow_back_ios_new,color: Colors.white,),
          null,
          Row(
            children: [
              Container(
                width: Get.width*0.75,
                height: Get.height*0.06,
                // color: Colors.red,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,color: Colors.black,),
                    hintText: "Search",
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              )
            ],
          ))),
    );
  }
}
