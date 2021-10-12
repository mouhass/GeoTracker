import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class thePage extends StatefulWidget {
  State<StatefulWidget> createState() => thePageState();
}

class thePageState extends State<thePage> {
  void getData() async {
    var url = Uri.parse('http://127.0.0.1:1234/geo/read_allgeo');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("hello world---");
    } else {
      print("error ------------------");
    }
  }

  double lat = 34.5;
  double long = 10.3;

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    lat = position.latitude;
    long = position.longitude;
    print(position.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text(location.getLocation().toString()),
          title: Text("Hello SIG"),
          actions: [
            TextButton(
              child: Text("click me", style: TextStyle(color: Colors.red)),
              onPressed: () {
                getData();
              },
            )
          ],
        ),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(lat, long),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) {
                return Text("");
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(lat, long),
                  builder: (ctx) => Container(
                    child: FlutterLogo(),
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.location_on),
          onPressed: () async {
            getLocation();
          },
        ));
  }
}
