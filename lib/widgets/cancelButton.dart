// ignore_for_file: prefer_const_constructors, unused_element, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';

import '../main.dart';

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '¿Estás seguro?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Text(
                    'Se perderá la información ingresada. ¿Estás seguro?',
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
          minimumSize: Size(100, 50), backgroundColor: Colors.blue),
      child: Text(
        'Cancelar',
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
    );
  }
}
