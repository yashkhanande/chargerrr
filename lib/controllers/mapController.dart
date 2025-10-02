import 'dart:async';
import 'dart:convert';
import 'package:chargerrr_app/services/directions_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../main.dart';
import '../models/station.dart';

class MapController extends GetxController{
  late MapboxMap mapboxMap;
  final station = Get.arguments as Station;
  late DirectionsService  directionsService;
  StreamSubscription? userPositionStream;
  var zoom = 15.0.obs;

  void zoomOut(){
    if(zoom.value > 1){
      zoom.value--;
      mapboxMap.setCamera(CameraOptions(zoom: zoom.value));
    }

  }
  void zoomIn(){
    if(zoom.value < 22){
      zoom.value++;
      mapboxMap.setCamera(CameraOptions(zoom: zoom.value));
    }
  }

  @override
  void onInit(){
    super.onInit();
    directionsService = DirectionsService(ACCESS_TOKEN);
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

  Future<void> setupLocationTracking() async {
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
      locationSettings:locationSettings).listen((geo.Position position) async {

        mapboxMap.setCamera(CameraOptions(
          center: Point(coordinates: Position(position.longitude, position.latitude))
        ));

        //draw route
        await _drawRoute(position.longitude, position.latitude);
    });

  }
  Future<void> _drawRoute(double userLon ,double userLat) async{
    final route = await directionsService.getRoute(userLon, userLat, station.longitude, station.latitude);

   //for avoiding duplicate routes
    try{
      await mapboxMap.style.removeStyleSource("route-source");
      await mapboxMap.style.removeStyleLayer("route-layer");
    } catch (_){}

    await mapboxMap.style.addSource(GeoJsonSource(
      id: 'route-source',
      data:jsonEncode({
        "type" : "Feature",
        "geometry" : {
          "type" : "LineString",
          "coordinates" : route,
        }


      })
    ));

    await mapboxMap.style.addLayer(LineLayer(
      id: 'route-layer',
      sourceId: "route-source",
      lineColor: Colors.blue.toARGB32(),
      lineWidth: 4.0,
      lineOpacity: 0.8
    ));

  }

}
