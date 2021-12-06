import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:geolocator/onboarding_page.dart';
import 'package:geolocator/road_drow.dart';
import 'package:geolocator/seConnecter/Sinscrire.dart';
import 'package:http/http.dart' as http;

class SeConnecter extends StatefulWidget {
  State<StatefulWidget> createState() => SeConnecterState();
}

class SeConnecterState extends State<SeConnecter> {
  Future<List<dynamic>> getInfos() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.100.178:1234/user/export'));
      if (response.statusCode == 200) {
        var usersResponse = jsonDecode(response.body);

        List<dynamic> users = [];

        for (int i = 0; i < usersResponse.length; i++) {
          users.add([usersResponse[i]['name'], usersResponse[i]['password']]);
        }

        return users;
      } else {
        return [];
      }
    } on Exception catch (_) {
      return [];
    }
  }

  Future<bool> verifyUser(
      String name, String password, Future<List<dynamic>> usersList) async {
    bool b = false;
    List<dynamic> ll = await usersList;
    print([name, password]);

    for (int i = 0; i < ll.length; i++) {
      print(ll[i]);
      if (ll[i][0] == name && ll[i][1] == password) {
        b = true;
      }
    }
    return b;
  }

  bool isObscure = true;
  String nom = "";
  String motDePasse = "";
  Widget _buidPassword() {
    return TextFormField(
      onChanged: (val) {
        motDePasse = val;
      },
      obscureText: isObscure,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Mot de passe',
          suffixIcon: IconButton(
              icon: Icon((isObscure == true)
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: () => setState(() {
                    print(isObscure);
                    isObscure = !isObscure;
                    print(isObscure);
                  }))),

      //validatePassword,        //Function to check validation
    );
  }

  Widget _buildNom() {
    return TextFormField(
      onChanged: (val) {
        nom = val;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nom',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Center(
              child: Text("Se connecter",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blue))),
        ),
        body: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Column(children: [
                  SizedBox(
                    height: h / 7,
                  ),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: _buildNom())),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: _buidPassword(),
                  )),
                  SizedBox(height: h / 10),
                  TextButton(
                    child: Container(
                        width: w - 60,
                        child: Center(
                          child: Text("Se connecter",
                              style: TextStyle(color: Colors.white)),
                        )),
                    onPressed: () async {
                      if (await verifyUser(nom, motDePasse, getInfos()) ==
                          true) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return OnBoardingPage();
                        }));
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red.shade300),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: Container(
                          child: Row(
                    children: [
                      SizedBox(width: 70),
                      Text(
                        "Vous avez déjà un compte?",
                        style: TextStyle(fontSize: 12),
                      ),
                      TextButton(
                        child: Text(
                          "Créer un nouveau",
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Sinscrire();
                          }));
                        },
                      )
                    ],
                  )))
                ]))));
  }
}
