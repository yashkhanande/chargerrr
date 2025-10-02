
import 'package:chargerrr_app/components/container_design.dart';
import 'package:chargerrr_app/models/station.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../controllers/mapController.dart';

class StationDetailView extends StatelessWidget{
  const StationDetailView ({super.key});
  @override

  Widget build(BuildContext context){
    final station = Get.arguments as Station;
    final _amenities = station.amenities;
    final mapController =Get.put(MapController());
    return Scaffold(
      appBar: AppBar(
        title: Text(station.name,style: TextStyle(
          fontWeight: FontWeight.w500
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ContainerDesign(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(station.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.grey),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            station.address,
                            style: TextStyle(color: Colors.grey.shade700,fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              ContainerDesign(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Row(
                     children: [
                       Image.asset('assets/energy.png',color: Colors.green.shade800,height: 20,),
                       const SizedBox(width:10 ,),
                       Text("Availability ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17)),
                     ],
                   ),
                    const SizedBox(height: 10,),
                    Text("${station.availablePoints} of ${station.totalPoints} chargers available",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),
                    const SizedBox(height: 10,),

                    SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width,
                      child: LinearProgressIndicator(
                        value: station.availablePoints / station.totalPoints,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.green)
                      ),
                    )

                  ],
                ),
              ),
              const SizedBox(height: 20,),
              ContainerDesign(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/wifi.png',color: Colors.green.shade800,width: 20,),
                        const SizedBox(width:10 ,),
                        Text("Amenities",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17)),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _amenities.length,
                      itemBuilder: ( context, index) {
                      return Text(_amenities[index].toUpperCase(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),);
                    },),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              ContainerDesign(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/placeholder.png',color: Colors.green.shade800,height: 20,),
                          const SizedBox(width:10 ,),
                          Text("Location ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17)),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Stack(
                        children: [
                          SizedBox(
                            height: 300,
                            child:Obx(()=> MapWidget(
                              onMapCreated:mapController.onMapCreated,
                              cameraOptions: CameraOptions(
                                  center: Point(coordinates: Position(station.longitude, station.latitude)),
                                  zoom: mapController.zoom.value
                              ),
                            ),
                            )

                          ),
                          Positioned(
                            bottom: 20,
                              right: 20,
                              child: ElevatedButton(onPressed: (){
                                mapController.setupLocationTracking();
                              }, child: Icon(Icons.location_on))),

                          Positioned(
                              bottom: 20,
                              left: 20,
                              child: Column(
                                children: [
                                  ElevatedButton(onPressed: (){
                                    mapController.zoomIn();
                                  }, child: Text("+")
                                  ),
                                  ElevatedButton(onPressed: (){
                                    mapController.zoomOut();
                                  }, child: Text("-")
                                  ),
                                ],
                              )),

                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}