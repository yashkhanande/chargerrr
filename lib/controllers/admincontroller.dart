import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdminController extends GetxController{
  final stationNameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final amenitiesController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final totalPointsController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future <void> saveStation() async {
    if(stationNameController.text.isEmpty  ||
    addressController.text.isEmpty ||
    cityController.text.isEmpty ||
    amenitiesController.text.isEmpty ||
    totalPointsController.text.isEmpty
    ){
       Get.snackbar("Error", "Please enter all fields");
       return;
    }
    double? lat = double.tryParse(latitudeController.text);
    double? lon = double.tryParse(longitudeController.text);

    if(lat == null || lon == null){
      Get.snackbar("Error", "Invalid location");
      return ;
    }

    List<String> amenitiesList = amenitiesController.text.split(',').map((item)=>item.trim()).where((item) =>item.isNotEmpty).toList();

    GeoPoint geoPoint = GeoPoint(lat ,lon);
   await _firestore
    .collection('stations')
    .add({
      'name' : stationNameController.text,
      'address' : addressController.text,
      'city' : cityController.text,
      'amenities' : amenitiesList,
      'available_poinst' : 0,
      'location' : geoPoint,
      'total_points' : int.tryParse(totalPointsController.text),
    }
    );

    Get.snackbar("Success", "Stations Saved");
  }
}