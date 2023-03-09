// ignore_for_file: avoid_print, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: AutofillHints.addressCityAndState,
              color: Colors.white),
          'MQTT CLIENT',
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(children: [
          Text(
            "\n\nESCUELA POLITECNICA NACIONAL\nFACULTAD DE INGENIERIA ELECTRICA Y ELECTRONICA\nINGENIERIA EN TECNOLOGIAS DE LA INFORMACION\n",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: AutofillHints.addressCityAndState),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 180,
            width: 180,
            child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/8/8c/Escudo_de_la_Escuela_Polit%C3%A9cnica_Nacional.png'),
          ),
          Text(
            "\nAPLICACION PARA LA ADMINISTRACION DE UN BASURERO INTELIGENTE\n\nSISTEMAS IoT\n",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: AutofillHints.addressCityAndState),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login');
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(220, 50), backgroundColor: Colors.blue),
              child: Text(
                'Acceder a la app',
                style: TextStyle(color: Colors.white, fontSize: 22),
              )),
          SizedBox(
            height: 75.0,
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
