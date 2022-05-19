// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:examples/features/google_maps/models/geometry.dart';

class Place {
  final Geometry geometry;
  final String name;
  final String vicinity;
  Place({
    required this.geometry,
    required this.name,
    required this.vicinity,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        geometry: Geometry.fromJson(json['geometry']),
        name: json['name'],
        vicinity: json['vicinity'],
      );
}
