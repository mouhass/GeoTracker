import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' ;
import 'package:google_fonts/google_fonts.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  MapController mapController = MapController(
    initMapWithUserPosition: true,
    initPosition: null,
  );

  @override
   Widget build(BuildContext context) {

    return
      Scaffold(
        appBar: AppBar(
          title:
            Text( 'Géo',
                style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.headline1,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                ),
            ),)
        ,body:
          OSMFlutter(
            controller:mapController,
            trackMyPosition: true,
            initZoom: 12,
            minZoomLevel: 8,
            maxZoomLevel: 14,
            stepZoom: 1.0,
            userLocationMarker: UserLocationMaker(
              personMarker: MarkerIcon(
                    icon: Icon(
                      Icons.location_history_rounded,
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
            )
        ),
      ));
  }
}
