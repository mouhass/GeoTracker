import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class thePage extends StatefulWidget {
  State<StatefulWidget> createState() => thePageState();
}

class thePageState extends State<thePage> {
  void sendData() async {
    var url = Uri.parse('http://10.0.2.2:5000/');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
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
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(36.813164, 10.079236),
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
                  point: LatLng(36.81314, 10.079236),
                  builder: (ctx) => Container(
                    child: FlutterLogo(),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
