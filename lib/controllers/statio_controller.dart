import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/station.dart';

class StationController extends GetxController{
  var stations = <Station>[].obs;
  var filteredStations = <Station>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStations();
  }

  void fetchStations() {
    FirebaseFirestore.instance
        .collection("stations")
        .snapshots()
        .listen((snapshot){
          stations.value = snapshot.docs
              .map((doc) => Station.fromFirestore(doc.data(),doc.id))
              .toList();
          filteredStations.assignAll(stations);
    });

  }

  void searchStations(String query) async{
    if(query.isEmpty){
      filteredStations.assignAll(stations);
    }
    else{
      final results = stations.where((station){
        final nameMatch = station.name.toLowerCase().contains(query.toLowerCase());
        final cityMatch = station.city.toLowerCase().contains(query.toLowerCase());
        return cityMatch || nameMatch ;
      }).toList();
      filteredStations.assignAll(results);
    }

  }
}