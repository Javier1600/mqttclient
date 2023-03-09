// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  static List<QueryDocumentSnapshot> _users = [];

  void getUsers() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    QuerySnapshot users = await collectionReference.get();
    if (users.docs.isNotEmpty) {
      _users = users.docs;
    }
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  void dispose() {
    _controllerUser.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  void clearTextFields() {
    _controllerUser.clear();
    _controllerPassword.clear();
  }

  void loginAlert(String title, String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(error),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50), backgroundColor: Colors.blue),
              child: Text(
                'Cerrar',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Ingrese sus credenciales"),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 150.0,
                  width: 150.0,
                  child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/4046/4046321.png'),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: _controllerUser,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'ejemplo@correo.com',
                        labelText: 'Correo electronico',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Por favor, ingrese un correo valido';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: _controllerPassword,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.password),
                        hintText: 'Contraseña',
                        labelText: 'Contraseña',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese su contraseña';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_controllerUser.text.isEmpty ||
                        _controllerPassword.text.isEmpty) {
                      loginAlert(
                          "Error", "Ingrese valores en los campos requeridos!");
                    } else {
                      for (var user in _users) {
                        String email = user['email'];
                        String password = user['password'];
                        if (_controllerUser.text == email) {
                          if (_controllerPassword.text == password) {
                            loginAlert("Inicio de sesion exitoso",
                                "Se ha establecido sesion de forma exitosa!");
                            Navigator.pushNamed(context, 'main');
                          } else {
                            loginAlert("Error", "Verifique sus credenciales");
                          }
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: Text(
                      'Iniciar sesion',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'signin');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: Text(
                      'Crear cuenta',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150.0,
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
              ],
            ),
          )),
    );
  }
}
