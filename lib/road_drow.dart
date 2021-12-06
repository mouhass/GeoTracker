import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class RoadDrow extends StatefulWidget {
  @override
  _RoadDrowState createState() => _RoadDrowState();
}

class _RoadDrowState extends State<RoadDrow> {
  // Future<http.Response> getInfos() {
  //   return http.get(Uri.parse('http://192.168.100.178:1234/geo/export'));
  // }
  List coordinatesList = [];
  getInfos() async {
    final response =
        await http.get(Uri.parse('http://192.168.100.178:1234/geo/export'));
    if (response.statusCode == 200) {
      print("it's fine hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      var jsonResponse = jsonDecode(response.body);
      for (int i = 0; i < jsonResponse.length; i++) {
        if (jsonResponse[i]['userName'] == "Mohamed Salah") {
          coordinatesList.add(jsonResponse[i]['coordinates']);
        }
      }
      print(coordinatesList[0]);
      print(coordinatesList[1]);

      return coordinatesList;
    } else {
      return [];
    }
  }

  var data = "Hello";

  @override
  MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
  );
  var tracking_points = {};
  var test = false;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: Text("Find your previous paths"),
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
            child: Icon(Icons.location_on, color: Colors.white),
            onPressed: () async {
              var myLocation = await mapController.myLocation();
              List ll = await getInfos();
              print(ll);
              //print(ll[1]);
              //print(ll[0]);

              // print(ll[0].substring(1, ll[0].length - 1) +
              //     "-------------------------");

              for (int j = 0; j < ll.length; j++) {
                List finalList = [];
                for (int i = 0; i < ll[j].length; i++) {
                  finalList.add([
                    double.parse(ll[j][i]
                        .substring(1, ll[j][i].length - 1)
                        .substring(10, 19)),
                    double.parse(ll[j][i]
                        .substring(1, ll[j][i].length - 1)
                        .substring(31, 41))
                  ]);
                  print(finalList);
                }
                // print(finalList);
                // print(finalList[0][0]);
                // print(finalList[0][1]);
                for (int i = 0; (i < finalList.length); i++) {
                  double y1 = finalList[i][0];
                  double y2 = finalList[i][1];

                  mapController.currentLocation().then(
                      (value) async => await mapController.enableTracking());

                  mapController.drawRoad(
                    GeoPoint(latitude: 36.818234, longitude: 10.075682),
                    GeoPoint(latitude: y1, longitude: y2),
                    roadType: RoadType.foot,
                    roadOption: RoadOption(
                        roadWidth: 10,
                        roadColor: Colors.blue,
                        showMarkerOfPOI: false),
                  );
                }
              }
            }));
  }
}
