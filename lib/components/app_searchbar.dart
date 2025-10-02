import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSearchbar extends StatelessWidget {
  const AppSearchbar ({super.key});
  @override
  Widget build(BuildContext context){
    return TextField(
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