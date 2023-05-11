// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';

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
                "For Convert Latitude and Longitude to Address👇",
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
                "For Convert Address to Latitude and Longitude👇",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Text(convertAddresstoLatLng),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  //** For Convert Latitude and Longitude to Address ********
                  final coordinates = Coordinates(31.4504, 73.1350);
                  var address = await Geocoder.local
                      .findAddressesFromCoordinates(coordinates);
                  var first = address.first;
                  print(first.addressLine);
                  setState(() {
                    convertLatLngToAddress = first.addressLine.toString();
                  });

                  //** For Convert Address to Latitude and Longitude ********

                  const query = "1600 Amphiteatre Parkway, Mountain View";
                  var addresses =
                      await Geocoder.local.findAddressesFromQuery(query);
                  var second = addresses.first;
                  print("${second.featureName} : ${second.coordinates}");

                  setState(() {
                    convertAddresstoLatLng = second.coordinates.toString();
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
