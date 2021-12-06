import 'package:flutter/material.dart';
import 'package:geolocator/seConnecter/seConnecter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class Sinscrire extends StatefulWidget {
  State<StatefulWidget> createState() => SinscrireState();
}

class SinscrireState extends State<Sinscrire> {
  createUser(String nom, String motDePasse) async {
    final response = await http.post(
        Uri.parse('http://192.168.100.178:1234/user/create'),
        body: {'name': nom, 'password': motDePasse});
    if (response.statusCode == 200) {
      print("yeah !!!!");
    } else {
      print("erreur !!!");
    }
  }

  String nom = "";
  String motDePasse = "";
  bool isObscure = true;
  Widget _buidPassword() {
    return TextFormField(
      obscureText: isObscure,
      onChanged: (val) => {motDePasse = val},
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

  Widget _buildName() {
    return TextFormField(
      onChanged: (val) => {nom = val},
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
              child: Text("S'inscrire",
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
                    child: _buildName(),
                  )),
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
                          child: Text("S'inscrire",
                              style: TextStyle(color: Colors.white)),
                        )),
                    onPressed: () {
                      createUser(nom, motDePasse);
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
                          "se connecter",
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SeConnecter();
                          }));
                        },
                      )
                    ],
                  )))
                ]))));
  }
}
