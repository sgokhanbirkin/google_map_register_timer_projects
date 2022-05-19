import 'dart:async';

import 'package:dio/dio.dart';
import 'package:examples/features/google_maps/service/places_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../../features/google_maps/models/place.dart';
import '../../features/google_maps/models/place_search.dart';
import '../../features/google_maps/service/geolocator_service.dart';

class ApplicationProvider with ChangeNotifier {
  final geoLocatorService = GeoLocatorService();
  final placesService = PlacesService(dio: Dio());

  late Position currentPosition;
  List<PlaceSearch> searchResults = [];
  late StreamController<Place> selectedLocation;

  bool loading = true;
  ApplicationProvider() {
    setCurrentLocation();
    selectedLocation = StreamController<Place>.broadcast();
  }

  _setLoading() {
    loading = !loading;
    notifyListeners();
  }

  setCurrentLocation() async {
    _setLoading();
    currentPosition = await geoLocatorService.getCurrentPosition();

    notifyListeners();
    _setLoading();
  }

  Future<void> searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }

  Future<void> selectPlace(String placeId) async {
    var place = await placesService.getPlace(placeId);
    selectedLocation.add(place);
    searchResults = [];
    notifyListeners();
  }

  @override
  void dispose() {
    searchResults = [];
    selectedLocation.close();
    super.dispose();
  }
}
