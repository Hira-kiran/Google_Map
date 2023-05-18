import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLines extends StatefulWidget {
  const PolyLines({super.key});

  @override
  State<PolyLines> createState() => _PolyLinesState();
}

class _PolyLinesState extends State<PolyLines> {
  // ****** for extra field access *********
  final Completer<GoogleMapController> _controller = Completer();
  // ******** For Camera position (like move) ********
  static const CameraPosition kGooglePlex =
      CameraPosition(target: LatLng(31.4504, 73.1350), zoom: 14.4746);

// ******** Latitube and longitude of different cities ************
  final List<LatLng> _latng = [
    const LatLng(31.4504, 73.1350),
    const LatLng(31.512452, 73.276388),
    const LatLng(31.427580, 73.283671),
    const LatLng(31.367484, 73.354819),
    const LatLng(31.5204,74.3587), // for polyline,we give it starting and endling position different******
  ];
  // *******Now we initialize polyline *******
  Set<Polyline> polyline = {};
  final Set<Marker> _marker = {};

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < _latng.length; i++) {
      _marker.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _latng[i],
          infoWindow:
              const InfoWindow(title: "Current Locarion", snippet: "hhhd"),
          icon: BitmapDescriptor.defaultMarker));
      setState(() {});

      polyline.add(Polyline(
          polylineId: const PolylineId("1"),
          points: _latng,
          color: Colors.orange));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("PolyLines"),
      ),
      body: GoogleMap(
        initialCameraPosition: kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: _marker,
        polylines: polyline,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
