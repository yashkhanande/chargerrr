import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../models/station.dart';

class MapController extends GetxController{
  late MapboxMap mapboxMap;
  final station = Get.arguments as Station;

  StreamSubscription? userPositionStream;

  @override
  void onInit(){
    super.onInit();
    _setupLocationTracking();
  }
  void onClose(){
  userPositionStream?.cancel();
  super.onClose();
  }
  void onMapCreated(MapboxMap controller) async{
    mapboxMap = controller;
    //user position
    mapboxMap.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
          pulsingEnabled: true,
        puckBearingEnabled: true
      )
    );
    //station location
    final pointAnnotationManager = await mapboxMap.annotations
    .createPointAnnotationManager();
    final Uint8List imageData = await _loadMarkerImage();

    PointAnnotationOptions pointAnnotationOptions = PointAnnotationOptions(
        geometry: Point(coordinates: Position(station.longitude, station.latitude)),
      image: imageData,
      iconSize: 0.3
    );
    await pointAnnotationManager.create(pointAnnotationOptions);
  }
  Future< Uint8List >_loadMarkerImage() async{
    var bytedata = await rootBundle.load("assets/placeholder.png");
    return bytedata.buffer.asUint8List();
  }

  Future<void> _setupLocationTracking() async {
    bool serviceEnabled;
    geo.LocationPermission permission;

    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error("Location Service Disabled");
    }

    permission =await geo.Geolocator.requestPermission();
    if(permission == geo.LocationPermission.denied || permission == geo.LocationPermission.deniedForever){
      return Future.error("Location permission denied");
    }

    geo.LocationSettings  locationSettings = geo.LocationSettings(
      accuracy : geo.LocationAccuracy.high,
      distanceFilter: 100
    );

    userPositionStream?.cancel();

    userPositionStream = geo.Geolocator.getPositionStream(
      locationSettings:locationSettings).listen((geo.Position position){

        mapboxMap.setCamera(CameraOptions(
          center: Point(coordinates: Position(position.longitude, position.latitude))
        ));
    });
  }

}
