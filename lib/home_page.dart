import 'package:flutter/material.dart';
import 'package:geolocator/data_export.dart';
import 'package:geolocator/map.dart';
import 'package:geolocator/road_drow.dart';
import 'main.dart';
import 'onboarding_page.dart';
import 'button_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'GeoLocator',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ButtonWidget(
                text: 'Start Tracking',
                onClicked: () => goToMap(context),
              ),
              const SizedBox(height: 24),
              ButtonWidget(
                text: 'Export Tracking Infos',
                onClicked: () => goToDataExport(context),
              ),
              const SizedBox(height: 24),
              ButtonWidget(
                text: 'Drow Road Lines',
                onClicked: () => goToRoadDrow(context),
              ),
            ],
          ),
        ),
      );

  void goToMap(context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => Map()));
  void goToDataExport(context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => ExportData()));
  void goToRoadDrow(context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => RoadDrow()));
}
