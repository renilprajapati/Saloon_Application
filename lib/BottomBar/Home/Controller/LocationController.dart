import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class LocationController extends GetxController{

  RxString currentCity = ''.obs;
  RxString  currentCityPincode = ''.obs;
  var locationLoading = false.obs;



  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      await getCityName(position.latitude, position.longitude);
    } catch (e) {
      print('Error getting location: $e');
      // Handle location retrieval error
    }
  }

  Future<void> getCityName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        if (kDebugMode) {
          currentCity.value = placemark.locality!;
          currentCityPincode.value = placemark.postalCode!;
          print('City: $currentCity,  pincode : $currentCityPincode , Country: ${placemark.country}');
        }
        // Use the city name or other location information as needed
      } else {
        print('No placemarks found');
      }
    } catch (e) {
      print('Error getting city name: $e');
      // Handle error
    }
  }

}