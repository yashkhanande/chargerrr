import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/station.dart';

class StationController extends GetxController{
  var stations = <Station>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchStations();
  }

  void fetchStations() {
    FirebaseFirestore.instance
        .collection("stations")
        .snapshots().listen((snapshot){
          stations.value = snapshot.docs
              .map((doc) => Station.fromFirestore(doc.data(),doc.id))
              .toList();
    });
  }
}