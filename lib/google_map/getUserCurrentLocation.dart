// ignore_for_file: file_names, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({super.key});

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {
  // ****** for extra field access *********
  final Completer<GoogleMapController> _controller = Completer();
  // ******** For Camera position (like move) ********
  static const CameraPosition kGooglePlex =
      CameraPosition(target: LatLng(31.4504, 73.1350), zoom: 14.4746);

  // ******** Now add Multiple Markers ********
  final List<Marker> _marker = [
    const Marker(
        markerId: MarkerId("1"),
        position: LatLng(31.4504, 73.1350),
        infoWindow: InfoWindow(title: "Faisalabad")),
    const Marker(
        markerId: MarkerId("2"),
        position: LatLng(31.5204, 74.3587),
        infoWindow: InfoWindow(title: "Lahore")),
  ];

  //******** For get current location of user */
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error);
    });
    return Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Get User Current Location"),
      ),
      body: GoogleMap(
        initialCameraPosition: kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //******** For get current location of user */
          getUserCurrentLocation().then((value) async {
            print("My Current Location");
            print(value.latitude.toString() + value.longitude.toString());
            // ******************************************
            _marker.add(
              Marker(
                  markerId: const MarkerId("3"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(title: "My Current Location")),
            );
            CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude), zoom: 14.4746);
            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}