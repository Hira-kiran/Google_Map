import 'package:flutter/material.dart';
import 'google_map/style_googleMap_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Map',
      home: StyleGoogleMapScreen(),
    );
  }
}
