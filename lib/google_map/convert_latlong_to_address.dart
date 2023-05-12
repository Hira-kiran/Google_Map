// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLngToAddress extends StatefulWidget {
  const ConvertLatLngToAddress({super.key});

  @override
  State<ConvertLatLngToAddress> createState() => _ConvertLatLngToAddressState();
}

class _ConvertLatLngToAddressState extends State<ConvertLatLngToAddress> {
  String convertLatLngToAddress = "";
  String convertAddresstoLatLng = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Google Map"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Convert Latitude and Longitude to Address👇",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(convertLatLngToAddress),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Convert Address to Latitude and Longitude👇",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(convertAddresstoLatLng),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  //** For Convert Latitude and Longitude to Address ********

                  List<Placemark> latLongToAddress =
                      await placemarkFromCoordinates(31.4504, 73.1350);

                  //** For Convert Address to Latitude and Longitude ********
                  List<Location> addressToLatLong =
                      await locationFromAddress("Gronausestraat 710, Enschede");
                  setState(() {
                    convertAddresstoLatLng =
                        "[${addressToLatLong.last.latitude.toString()} + ${addressToLatLong.last.longitude.toString()}]";
                    convertLatLngToAddress =
                        "${latLongToAddress.reversed.last.street} ${latLongToAddress.reversed.last.locality} ${latLongToAddress.reversed.last.country}. ";
                  });
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                      child: Text(
                    "Convert",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ),
              )
            ]),
      ),
    );
  }
}
