import 'package:chargerrr_app/components/app_searchbar.dart';
import 'package:chargerrr_app/components/my_appbar.dart';
import 'package:chargerrr_app/components/stations_card.dart';
import 'package:chargerrr_app/controllers/statio_controller.dart';
import 'package:chargerrr_app/presentation/auth/login_page.dart';
import 'package:chargerrr_app/presentation/station_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    StationController stationController = Get.put(StationController());
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppSearchbar(),
              const SizedBox(height: 10),
              TextButton.icon(onPressed: (){
                  Get.offAll(()=>LoginPage());
                }, label: Row(
                  children: [
                    Text("LogOut"),
                    const SizedBox(width: 10,),
                    Icon(Icons.exit_to_app)
                  ],
                )),
              Obx(() {
                return Row(
                  children: [
                    Text("${stationController.filteredStations.length} Stations found"),
                    Spacer(),
                  ],
                );
              }),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  if (stationController.filteredStations.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    itemCount: stationController.filteredStations.length,
                    itemBuilder: (context, index) {
                      final station = stationController.filteredStations[index];
                      return StationsCard(
                        stationName: station.name,
                        availablePoints: station.availablePoints,
                        totalPoints: station.totalPoints,
                        address: station.address,
                        onPressed: () {
                          Get.to(() => StationDetailView(), arguments: station);
                        },
                        amenities: station.amenities,
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
