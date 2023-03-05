// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mqttclient/pages/home.dart';

class SensorLayout extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> user;
  final String userName;
  const SensorLayout(this.user, this.userName, {Key? key}) : super(key: key);

  @override
  State<SensorLayout> createState() => _SensorLayoutState();
}

class _SensorLayoutState extends State<SensorLayout> {
  static late QueryDocumentSnapshot<Object?> user;
  static String _username = '';
  @override
  void initState() {
    super.initState();
    user = widget.user;
    _username = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bienvenido " + _username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Divider(
            thickness: 3,
            color: Colors.blue,
          ),
          Column(
            children: [
              Text(
                'Sensor DHT11',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Divider(
            thickness: 3,
            color: Colors.blue,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 3.0,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "\t\tTemperatura ",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "25.3 ºC",
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 3.0,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "\t\tHumedad ",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "25.3 ºC",
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Divider(
            thickness: 3,
            color: Colors.blue,
          ),
          Text(
            "Ultrasónico",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            thickness: 3,
            color: Colors.blue,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 3.0,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Distancia ",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "25.3 cm",
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(user, user['nombre'])));
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 50), backgroundColor: Colors.blue),
            child: Text(
              "Volver",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          SizedBox(
            height: 120,
          ),
          Divider(
            thickness: 5,
            color: Colors.blue,
          ),
          Text(
            "Derechos reservados para:\n Laura Montalvo & Javier Andrade",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                fontFamily: AutofillHints.addressCityAndState),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
