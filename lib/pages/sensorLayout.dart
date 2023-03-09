// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:mqttclient/connection/mqtt.dart';
import 'package:mqttclient/helpers/sensorsValuesProvider.dart';
import 'package:provider/provider.dart';

class SensorLayout extends StatefulWidget {
  const SensorLayout({super.key});

  @override
  State<SensorLayout> createState() => _SensorLayoutState();
}

class _SensorLayoutState extends State<SensorLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SensorValuesProvider state = Provider.of<SensorValuesProvider>(context);
    MQTTConnect client = MQTTConnect(
        host: '192.168.43.211',
        topicSub: 'apertura',
        topicPub: 'basurero',
        identifier: '',
        state: state);
    client.initializeMQTTClient();
    Future.delayed(Duration.zero, () {
      client.connect();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bienvenido ",
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
                      "${state.Temperature.toString()} ºC",
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
                      "${state.Humidity.toString()} %",
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                    ),
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
                    "${state.Distance.toString()} cm",
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              client.disconnect();
              Navigator.pushNamed(context, 'main');
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 50), backgroundColor: Colors.blue),
            child: Text(
              "Volver",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          SizedBox(
            height: 50,
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
