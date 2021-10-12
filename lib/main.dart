import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geotracker/thePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: thePage(),
    );
  }
}
