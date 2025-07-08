import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Auth/Screens/login_ignup_screen.dart';
import 'package:saloon_app/BottomBar/BottomScreen/BottomBarScreen.dart';
import 'package:saloon_app/BottomBar/Home/Controller/LocationController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  String? userID = '';
  Future<void> getUserId() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    userID = sh.getString("userId");
    if (kDebugMode) {
      print("userid ${userID}");
    }
  }

  final LocationController _locationCont_obj = Get.put(LocationController());

  @override
  void initState() {
    checkLocationPermission().then((value) {
      getUserId().then((value) {
        Timer(const Duration(seconds: 3), () {
          if (userID == null || userID == 'null') {
            Get.offAll(() => const loginSignupScreen());
          } else {
            Get.offAll(() => BottomBarScreen());
          }
        });
      });
    });
    super.initState();
  }

  Future<void> checkLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      while (permission == LocationPermission.denied) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Location Permission Required'),
            content: Text('Please grant location permission to use this app.'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  permission = await Geolocator.requestPermission();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
      if (permission == LocationPermission.deniedForever) {
        // Handle permission permanently denied
        return;
      }
    } on Exception catch (e) {
      // TODO
      print("Error :$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Image.asset("assets/images/splash.png")),
    );
  }
}
