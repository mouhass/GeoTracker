import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:proj4dart/proj4dart.dart';

class ThePage extends StatefulWidget {
  State<StatefulWidget> createState() => ThePageState();
}

class ThePageState extends State<ThePage> {
  double long = 49.5;
  double lat = 0.09;
  LatLng point = LatLng(49.5, -0.09);
  var location;
  void sendData() async {
    var url = Uri.parse('http://localhost:1244/geo/test/');
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("hello world"),
          actions: [
            TextButton(
              child: Text("click me", style: TextStyle(color: Colors.red)),
              onPressed: () {
                sendData();
              },
            )
          ],
        ),
        body: Stack(children: [
          FlutterMap(
            options: MapOptions(
              onTap: (p) /*async*/ {
                // location = await Geocoder.local.findAddressesFromCoordinates(
                //     Coordinates(p.latitude, p.longitude));

                setState(() {
                  point = p;
                });
              },
              center: LatLng(36.813164, 10.079236),
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                // attributionBuilder: (_) {
                //   return Text("");
                // },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: point,
                    builder: (ctx) => Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on_outlined),
                            hintText: "Search for location",
                            contentPadding: EdgeInsets.all(16.0)),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ]));
  }
}
