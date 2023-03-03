// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mqttclient/pages/home.dart';
import 'package:mqttclient/pages/signin.dart';

class LoginPage extends StatefulWidget {
  final List<QueryDocumentSnapshot> users;
  static String id = 'login_page';
  const LoginPage(this.users, {Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static String _emailValidator = '';
  static String _passwordValidator = '';
  static String _errorLogin = '';
  static List<QueryDocumentSnapshot> _users = [];

  @override
  Widget build(BuildContext context) {
    _users = widget.users;
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
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: _userTextField(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: _passwordTextField(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  _errorLogin,
                  style: TextStyle(color: Colors.red),
                ),
                _buttonLogin(),
                SizedBox(
                  height: 20.0,
                ),
                _buttonSignIn(),
                SizedBox(
                  height: 300.0,
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

Widget _userTextField() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electronico',
        ),
        validator: (value) {
          _LoginPageState._emailValidator = value.toString();
          if (value == null || value.isEmpty || !value.contains('@')) {
            return 'Por favor, ingrese un correo valido';
          }
          _LoginPageState._errorLogin = '';
          return null;
        },
      ),
    );
  });
}

Widget _passwordTextField() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.password),
          hintText: 'Contraseña',
          labelText: 'Contraseña',
        ),
        validator: (value) {
          _LoginPageState._passwordValidator = value.toString();
          if (value == null || value.isEmpty) {
            return 'Por favor, ingrese su contraseña';
          }
          _LoginPageState._errorLogin = '';
          return null;
        },
      ),
    );
  });
}

Widget _buttonLogin() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return ElevatedButton(
      onPressed: () {
        if (_LoginPageState._emailValidator.isEmpty ||
            _LoginPageState._passwordValidator.isEmpty) {
          _LoginPageState._errorLogin = 'Ingrese valores a los campos!';
        } else {
          for (var user in _LoginPageState._users) {
            String email = user.get('email') as String;
            String password = user.get('password') as String;
            if (_LoginPageState._emailValidator == email) {
              if (_LoginPageState._passwordValidator == password) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              } else {
                _LoginPageState._errorLogin = "Verifique sus credenciales";
              }
            } else {
              _LoginPageState._errorLogin = "Verifique sus credenciales";
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
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Text(
          'Iniciar sesion',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  });
}

Widget _buttonSignIn() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Signin()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Text(
          'Crear cuenta',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  });
}
