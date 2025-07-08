import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Auth/Screens/splash_screen.dart';
import 'package:saloon_app/BottomBar/Home/Screen/SearchSaloonScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Unisex Saloon',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: splashScreen());
  }
}
