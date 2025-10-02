import 'dart:convert';

import 'package:http/http.dart' as http;

class DirectionsService{
  final String accessToken;

  DirectionsService(this.accessToken);

  Future <List<List<double>>> getRoute(double fromLon , double fromLat ,double toLon ,double toLat) async {
    final url = Uri.parse('https://api.mapbox.com/directions/v5/mapbox/driving/$fromLon,$fromLat;$toLon,$toLat?geometries=geojson&access_token=$accessToken');

    final responce = await http.get(url);

    if(responce.statusCode == 200){
      final data = jsonDecode(responce.body);
      final coords = data['routes'][0]['geometry']['coordinates'] as List;
      return coords.map<List<double>>((c)=> [c[0],c[1]]).toList();
    }else {
      throw Exception("Failed to fetch directions");
    }
  }
}