import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkersScreen extends StatefulWidget {
  const CustomMarkersScreen({super.key});

  @override
  State<CustomMarkersScreen> createState() => _CustomMarkersScreenState();
}

class _CustomMarkersScreenState extends State<CustomMarkersScreen> {
  // ****** for extra field access *********
  final Completer<GoogleMapController> _controller = Completer();
  // ******** For Camera position (like move) ********
  static const CameraPosition kGooglePlex =
      CameraPosition(target: LatLng(31.4504, 73.1350), zoom: 14.4746);

// ******** Latitube and longitude of different cities ************
  final List<LatLng> _lating = [
    const LatLng(31.4504, 73.1350),
    const LatLng(33.6844, 73.0479),
    const LatLng(31.5204, 74.3587),
  ];
  // *********** images *****************
  List images = [
    "images/bus.png",
    "images/car.png",
    "images/bus.png",
  ];

  Uint8List? markerImages;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // ******** Now add Multiple Markers ********
  final List<Marker> _marker = [];

  // ** for adding markers images

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon =
          await getBytesFromAsset(images[i].toString(), 100);

      _marker.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _lating[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: "This is marker$i",
          )));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
