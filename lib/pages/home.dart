// ignore_for_file: prefer_const_constructors, annotate_overrides, override_on_non_overriding_member, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mqttclient/pages/sensorLayout.dart';
import 'package:mqttclient/widgets/responseDialog.dart';

class Home extends StatefulWidget {
  static int activationController = 1;
  static String buttonTextcontroller = 'Desactivar apertura';
  final QueryDocumentSnapshot user;
  final String userName;
  const Home(this.user, this.userName, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static late QueryDocumentSnapshot<Object?> user;
  static String _userName = '';
  @override
  void initState() {
    super.initState();
    user = widget.user;
    _userName = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Bienvenido " + _userName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Pulse en una de las opciones:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30.0,
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return myDialog(context);
                },
              );
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(220, 50), backgroundColor: Colors.blue),
            child: const Text(
              "Activar/Desactivar apertura",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SensorLayout(user, user['nombre'])));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50), backgroundColor: Colors.blue),
              child: Text(
                'Información sensores',
                style: TextStyle(color: Colors.white, fontSize: 22),
              )),
          SizedBox(
            height: 10,
          ),
          MyAlertDialog(),
          SizedBox(
            height: 350,
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

Widget myDialog(BuildContext context) {
  if (Home.activationController == 1) {
    Home.activationController = 0;
    return AlertDialog(
      title: Text(
        'Informacion',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      content: Text(
        'Se desactivó la apertura. Vuelva a pulsar para activarla',
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              minimumSize: Size(80, 50), backgroundColor: Colors.blue),
          child: Text(
            'Cerrar',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ],
    );
  } else {
    Home.activationController = 1;
    Home.buttonTextcontroller = '';
    return AlertDialog(
      title: Text(
        'Informacion',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      content: Text('Se activó la apertura. Vuelva a pulsar para desactivarla'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              minimumSize: Size(80, 50), backgroundColor: Colors.blue),
          child: Text(
            'Cerrar',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ],
    );
  }
}
