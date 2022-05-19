import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/google_map_provider.dart';
import '../models/directons.dart';
import '../models/place.dart';
import '../service/directions_service.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSubscription;
  late TextEditingController searchController;

  Marker? _origin;
  Marker? _destination;
  Directions? _info;

  @override
  void initState() {
    searchController = TextEditingController();
    final applicationProvider = Provider.of<ApplicationProvider>(context, listen: false);

    locationSubscription = applicationProvider.selectedLocation.stream.listen((place) {
      _goToPlace(place);
    });

    super.initState();
  }

  @override
  void dispose() {
    locationSubscription.pause();
    searchController.dispose();

    super.dispose();
  }

  void clearMarkers() {
    setState(() {
      _origin = null;
      _destination = null;
      _info = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: (applicationProvider.loading == false)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  _searchBar(applicationProvider),
                  Expanded(
                    child: Stack(
                      children: [
                        _googleMap(applicationProvider),
                        if (_info != null) _distanceInfo(size),
                        if (applicationProvider.searchResults.isNotEmpty) _darkOpacityContainer(),
                        if (applicationProvider.searchResults.isNotEmpty) _searchList(applicationProvider)
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Positioned _distanceInfo(Size size) {
    return Positioned(
      top: size.height * 0.03,
      left: size.width / 2 - size.width * 0.2,
      child: Container(
        width: size.width * 0.40,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.yellowAccent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6),
          ],
        ),
        child: Center(
          child: Text('${_info?.totalDistance} , ${_info?.totalDuration}', style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  ListView _searchList(ApplicationProvider applicationProvider) {
    return ListView.builder(
      itemCount: applicationProvider.searchResults.length,
      itemBuilder: (context, index) {
        final placeSearch = applicationProvider.searchResults[index];
        return ListTile(
          title: Text(
            placeSearch.description,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          onTap: () {
            clearMarkers();
            applicationProvider.selectPlace(
              applicationProvider.searchResults[index].placeId,
            );
          },
        );
      },
    );
  }

  Container _darkOpacityContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.6),
        backgroundBlendMode: BlendMode.darken,
      ),
    );
  }

  GoogleMap _googleMap(ApplicationProvider applicationProvider) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: {
        if (_origin != null) _origin!,
        if (_destination != null) _destination!,
      },
      onLongPress: _addMarker,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          applicationProvider.currentPosition.latitude,
          applicationProvider.currentPosition.longitude,
        ),
        zoom: 12,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      polylines: {
        if (_info != null)
          Polyline(
            polylineId: const PolylineId('overview_polyLine'),
            visible: true,
            points: _info!.polylinePoints
                .map((point) => LatLng(
                      point.latitude,
                      point.longitude,
                    ))
                .toList(),
            color: Colors.red,
            width: 5,
          ),
      },
    );
  }

  Padding _searchBar(ApplicationProvider applicationProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          labelText: 'Search',
        ),
        controller: searchController,
        onChanged: (value) => applicationProvider.searchPlaces(value),
      ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            place.geometry.location.lat,
            place.geometry.location.lng,
          ),
          zoom: 15,
        ),
      ),
    );

    searchController.text = '';
  }

  void _addMarker(LatLng positon) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: positon,
        );
        _destination = null;
        _info = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: positon,
        );
      });
    }
    if (_origin != null && _destination != null) {
      final directions = await DirectionService(dio: Dio()).getDirections(
        origin: _origin!.position,
        destination: positon,
      );
      setState(() {
        _info = directions;
      });
    }
  }
}
