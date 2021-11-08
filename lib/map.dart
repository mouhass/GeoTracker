import 'dart:io';

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
            child: Text('P'),
            onPressed: () async {
              print('position button pressed');
              var myLocation = await mapController.myLocation();
              mapController.currentLocation().then( (value) async => await mapController.enableTracking());
              await mapController.drawRoad(
                  myLocation,
                GeoPoint(latitude: 47.4361, longitude: 8.6156),
                  roadType: RoadType.car,
                  intersectPoint : [GeoPoint(latitude: 47.4371, longitude: 8.6136)],
                  roadOption: RoadOption(
                    roadWidth: 10,
                    roadColor: Colors.blue,
                    showMarkerOfPOI: false
                  ),
              );
              print('current position');
            }
            // mapController.disabledTracking();
            //mapController.setZoom(zoomLevel: 18);
            )
    );
  }
}
