import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({super.key});

  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {
  // ****** for extra field access *********
  final Completer<GoogleMapController> _controller = Completer();
  // ******** For Camera position (like move) ********
  static const CameraPosition kGooglePlex =
      CameraPosition(target: LatLng(31.4504, 73.1350), zoom: 14.4746);

// ******** Latitube and longitude of different cities ************
  final List<LatLng> _lating = [
    const LatLng(31.4504, 73.1350),
    const LatLng(31.533324, 73.185419),
    const LatLng(31.465497, 73.066934),
    const LatLng(31.484645, 73.128317),
    const LatLng(31.4504,
        73.1350), // for polygon try to write same starting and endling cordinates******
  ];
  // *******Now we initialize polygon *******

  Set<Polygon> polygon = HashSet<Polygon>();

  @override
  void initState() {
    super.initState();
    polygon.add(Polygon(
        polygonId: const PolygonId("1"),
        points: _lating,
        fillColor: Colors.orange.withOpacity(0.3),
        geodesic: true,
        strokeWidth: 2,
        strokeColor: Colors.black));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Polygon Screen"),
      ),
      body: GoogleMap(
        initialCameraPosition: kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        polygons: polygon,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
