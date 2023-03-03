// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../main.dart';

class MyAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            bool _response = false;
            return AlertDialog(
              title: Text(
                '¿Estás seguro?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyApp()));
          }
        });
      },
      style: ElevatedButton.styleFrom(
          minimumSize: Size(300, 50), backgroundColor: Colors.blue),
      child: Text(
        'Cerrar Sesión',
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
    );
  }
}