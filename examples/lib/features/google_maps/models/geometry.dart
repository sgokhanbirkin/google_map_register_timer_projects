import 'package:examples/features/google_maps/models/location.dart';

class Geometry {
  final Location location;

  Geometry({
    required this.location,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json['location']),
      );
}
