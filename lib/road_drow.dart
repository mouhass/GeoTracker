import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RoadDrow extends StatefulWidget {
  @override
  _RoadDrowState createState() => _RoadDrowState();
}

class _RoadDrowState extends State<RoadDrow> {
  Future<http.Response> getInfos() {
    return http.get(Uri.parse('http://192.168.43.87:1234/geo/export'));
  }

  var data = "Hello";

  @override
  Widget build(BuildContext context) {
    this.getInfos().then((data) {
      this.data = data.body;
    });
    return FutureBuilder(
      future: getInfos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Processing .."),
              ),
              body: Center(child: Text("Thank you for your patience")));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Scaffold(
                appBar: AppBar(
                  title: Text("Road Map"),
                ),
                body: Column(children: [Text("this is a MAP ROAD Drow")]));
        }
      },
    );
  }
}
