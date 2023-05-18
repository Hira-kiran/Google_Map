// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({super.key});

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  String mapTheme = "";
  // ****** for extra field access *********
  final Completer<GoogleMapController> _controller = Completer();
  // ******** For Camera position (like move) ********
  static const CameraPosition kGooglePlex =
      CameraPosition(target: LatLng(31.4504, 73.1350), zoom: 14.4746);

//******** for add google map themes *********** */
  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/mapThemes/standardTheme.json")
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Style Google Map"),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString("assets/mapThemes/silverTheme.json")
                                .then((val) {
                              value.setMapStyle(val);
                            });
                          });
                        },
                        child: const Text("Silver")),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString("assets/mapThemes/nightTheme.json")
                                .then((val) {
                              value.setMapStyle(val);
                            });
                          });
                        },
                        child: const Text("Night")),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString(
                                    "assets/mapThemes/standardTheme.json")
                                .then((val) {
                              value.setMapStyle(val);
                            });
                          });
                        },
                        child: const Text("Standard")),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString("assets/mapThemes/retroTheme.json")
                                .then((val) {
                              value.setMapStyle(val);
                            });
                          });
                        },
                        child: const Text("Retro")),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString("assets/mapThemes/aubergin.json")
                                .then((val) {
                              value.setMapStyle(val);
                            });
                          });
                        },
                        child: const Text("Aubergin")),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString("assets/mapThemes/darkTheme.json")
                                .then((val) {
                              value.setMapStyle(val);
                            });
                          });
                        },
                        child: const Text("Dark"))
                  ]),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: kGooglePlex,

        myLocationEnabled: true,

        // markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(mapTheme);
          _controller.complete(controller);
        },
      ),
    );
  }
}
