// ignore_for_file: prefer_const_constructors, annotate_overrides, override_on_non_overriding_member, prefer_interpolation_to_compose_strings, unused_local_variable

import 'package:flutter/material.dart';
import 'package:mqttclient/helpers/sensorsValuesProvider.dart';
import 'package:mqttclient/pages/initialPage.dart';
import 'package:provider/provider.dart';
import '../connection/mqtt.dart';

class Home extends StatefulWidget {
  static int activationController = 1;
  static String buttonTextcontroller = 'Desactivar apertura';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SensorValuesProvider state = context.watch<SensorValuesProvider>();
    MQTTConnect client = MQTTConnect(
        host: '192.168.43.211',
        topicSub: 'basurero',
        topicPub: 'apertura',
        identifier: '',
        state: state);
    client.initializeMQTTClient();
    Future.delayed(Duration.zero, () {
      client.connect();
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              if (Home.activationController == 1) {
                client.publish('off');
              } else {
                client.publish('on');
              }
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
                client.disconnect();
                Navigator.pushNamed(context, 'sensors');
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
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      '¿Estás seguro?',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Text(
                          'Se cerrará la sesion. ¿Estás seguro?',
                        );
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        child: Text(
                          'No',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          client.disconnect();
                          Navigator.of(context).pop(true);
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        child: Text(
                          'Sí',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  );
                },
              ).then((value) {
                if (value == true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()));
                }
              });
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 50), backgroundColor: Colors.blue),
            child: Text(
              'Cerrar Sesión',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
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
