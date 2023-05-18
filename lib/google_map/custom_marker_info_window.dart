import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ************ Use pkg (custom_info_window: ^1.0.1)
class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  // ********** Initialize pkg custom info window *************
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  final List<Marker> _marker = [];
// ******** Latitube and longitude of different cities ************
  final List<LatLng> _lating = [
    const LatLng(31.4504, 73.1350),
    const LatLng(33.6844, 73.0479),
    const LatLng(31.5204, 74.3587),
  ];

  loadData() async {
    for (int i = 0; i < _lating.length; i++) {
      _marker.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _lating[i],
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            customInfoWindowController.addInfoWindow!(
                Container(
                  height: 50,
                  width: 100,
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: const ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text("Hira"),
                  ),
                ),
                _lating[i]);
          }));
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Custom Marker Info Window"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
                target: LatLng(31.4504, 73.1350), zoom: 14.4746),
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_marker),
            onTap: (position) {
              customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: 50,
            width: 200,
            offset: 35,
          )
        ],
      ),
    );
  }
}
