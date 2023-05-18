import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ****** for extra field access *********
  final Completer<GoogleMapController> _controller = Completer();
  // ******** For Camera position (like move) ********
  static const CameraPosition kGooglePlex =
      CameraPosition(target: LatLng(31.4504, 73.1350), zoom: 14.4746);

// ******** Now add Multiple Markers ********
  final List<Marker> _marker = [];
  final List<Marker> _list = [
    const Marker(
        markerId: MarkerId("1"),
        position: LatLng(31.4504, 73.1350),
        infoWindow: InfoWindow(title: "Faisalabad")),
    const Marker(
        markerId: MarkerId("2"),
        position: LatLng(31.5204, 74.3587),
        infoWindow: InfoWindow(title: "Lahore")),
    const Marker(
        markerId: MarkerId("3"),
        position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(title: "Islambaad")),
  ];
  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Google Map"),
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
      /*   floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //******** Animate camera to move to any positio on google map */
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              const CameraPosition(
                  target: LatLng(37.42796133580664, -122.085749655962))));
          setState(() {});
        },
        child: const Icon(Icons.location_on),
      ), */
    );
  }
}
