// ignore_for_file: file_names, avoid_print, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleSearchPlaceApi extends StatefulWidget {
  const GoogleSearchPlaceApi({super.key});

  @override
  State<GoogleSearchPlaceApi> createState() => _GoogleSearchPlaceApiState();
}

class _GoogleSearchPlaceApiState extends State<GoogleSearchPlaceApi> {
  final _searchController = TextEditingController();
  var uid = const Uuid();
  String _sessionToken = "123455";
  List _placesList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uid.v4();
      });
    }
    getSuggestion(_searchController.text);
  }

  void getSuggestion(String input) async {
    String placeApiKey = "add place api";
    String baseURL = "";
    String request =
        "$baseURL?input=$input&key=$placeApiKey&_sessionToken=$_sessionToken";
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);
    if (response.statusCode == 200) {
      _placesList = jsonDecode(response.body.toString())["predictions"];
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Get User Current Location"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
                  hintText: "Search Places", border: OutlineInputBorder()),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _placesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){
                        
                      },
                      title: Text(_placesList[index]["description"]),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
