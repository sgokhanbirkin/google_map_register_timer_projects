import 'package:dio/dio.dart';

import '../../../.env.dart';
import '../models/place.dart';
import '../models/place_search.dart';

class PlacesService {
  final String keyValue = googleAPIkey;
  final Dio _dio;

  PlacesService({required Dio dio}) : _dio = dio;

  Future<List<PlaceSearch>> getAutoComplete(String search) async {
    var baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$keyValue';
    final response = await _dio.get(baseUrl);
    var predictions = response.data['predictions'] as List;
    var places = predictions.map((p) => PlaceSearch.fromJson(p)).toList();
    return places;
  }

  Future<Place> getPlace(String placeId) async {
    var baseUrl = 'https://maps.googleapis.com/maps/api/place/details/json?key=$keyValue&place_id=$placeId';
    var response = await _dio.get(baseUrl);
    var jsonResult = response.data['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }
}
