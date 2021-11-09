import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_fonts/google_fonts.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
  );

  var tracking_points = {};
  var test = false;
  Future<http.Response> send(points) {
    print(points);
    return http.post(Uri.parse('http://192.168.43.87:1234/geo/create'),
        body: points);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Géo',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme.of(context).textTheme.headline1,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        body: OSMFlutter(
          onLocationChanged: (data) {
            this
                .tracking_points["coordinates"]
                .add({"latitude": data.latitude, "longitude": data.longitude});
          },
          controller: mapController,
          trackMyPosition: true,
          initZoom: 18,
          minZoomLevel: 2,
          maxZoomLevel: 19,
          stepZoom: 1.0,
          userLocationMarker: UserLocationMaker(
            personMarker: MarkerIcon(
              icon: Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 48,
              ),
            ),
            directionArrowMarker: MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
                size: 48,
              ),
            ),
          ),
          road: Road(
            startIcon: MarkerIcon(
              icon: Icon(
                Icons.person,
                size: 64,
                color: Colors.brown,
              ),
            ),
            roadColor: Colors.yellowAccent,
          ),
          markerOption: MarkerOption(
              defaultMarker: MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 56,
            ),
          )),
        ),
        floatingActionButton: FloatingActionButton(
            child: Text(this.test ? 'Stop' : "Start"),
            onPressed: () async {
              if (!this.test) {
                this.test = true;
                this.tracking_points["date"] = DateTime.now().toString();
                this.tracking_points["coordinates"] = [];
                mapController.currentLocation().then(
                    (value) async => await mapController.enableTracking());
                var waysPoint = [
                  GeoPoint(latitude: 36.8135391, longitude: 10.0637389),
                  GeoPoint(latitude: 36.80503, longitude: 10.18102)
                ];
                await mapController.drawRoadManually(
                  waysPoint,
                  Colors.purpleAccent,
                  6.0,
                );
              } else {
                this.test = false;
                await mapController.disabledTracking();
                this.tracking_points["coordinates"] =
                    this.tracking_points["coordinates"].toString();
                print(this.tracking_points);
                var x = await this.send(this.tracking_points);
                print(this.tracking_points);
              }
            }

            ));
  }
}
