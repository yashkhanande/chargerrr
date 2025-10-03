import 'package:chargerrr_app/controllers/statio_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';


class AppSearchbar extends StatelessWidget {
  const AppSearchbar ({super.key});
  @override
  Widget build(BuildContext context){
    TextEditingController query = TextEditingController();

    return TextField(
      controller: query,
      onChanged: (value){
       StationController stationController = Get.find();
       stationController.searchStations(value);
      },
      decoration: InputDecoration(
        hint : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search),
            const SizedBox(width: 20,),
            Text("Search Stations by Name or Location"),
          ],
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide:BorderSide.none,
          borderRadius: BorderRadius.circular(12)
        )
      ),
    );
  }
}