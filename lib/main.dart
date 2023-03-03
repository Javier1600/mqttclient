// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mqttclient/pages/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<QueryDocumentSnapshot> _users = [];
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    QuerySnapshot users = await collectionReference.get();
    if (users.docs.isNotEmpty) {
      _users = users.docs;
    }
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
            "\n\nESCUELA POLITECNICA NACIONAL\n\nFACULTAD DE INGENIERIA ELECTRICA Y ELECTRONICA\n\nINGENIERIA EN TECNOLOGIAS DE LA INFORMACION\n\nSISTEMAS IoT\n\n APLICACION PARA LA ADMINISTRACION DE UN BASURERO INTELIGENTE",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                fontFamily: AutofillHints.addressCityAndState),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage(_users)));
                for (var element in _users) {
                  print(element.data());
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(220, 50), backgroundColor: Colors.blue),
              child: Text(
                'Acceder a la app',
                style: TextStyle(color: Colors.white, fontSize: 22),
              )),
          SizedBox(
            height: 200.0,
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
