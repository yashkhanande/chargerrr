import 'package:cloud_firestore/cloud_firestore.dart';
class Station {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int availablePoints;
  final int totalPoints;
  final List<String> amenities;

  Station({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.availablePoints,
    required this.totalPoints,
    required this.amenities,
  });

  factory Station.fromFirestore(Map<String, dynamic> json, String id) {
    final GeoPoint geo = json ["location"] as GeoPoint;
    return Station(
      id: id,
      name: json["name"] ?? "",
      address: json["address"] ?? "",
      latitude: geo.latitude,
      longitude: geo.longitude,
      availablePoints: json["available_points"] ?? 0,
      totalPoints: json["total_points"] ?? 0,
      amenities: List<String>.from(json["amenities"] ?? []),
    );
  }
}
