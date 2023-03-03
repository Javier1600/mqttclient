// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  static String _emailValidator = '';
  static String _passwordValidator = '';
  static String _errorLogin = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Ingrese sus credenciales",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
                  child: _emailTextField(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: _repeatEmailTextField(),
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
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: _repeatPasswordTextField(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  _errorLogin,
                  style: TextStyle(color: Colors.red),
                ),
                //_buttonLogin(),
                SizedBox(
                  height: 20.0,
                ),
                //_buttonSignIn(),
                SizedBox(
                  height: 20.0,
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
          icon: Icon(Icons.person),
          hintText: 'Nombre Apellido',
          labelText: 'Nombre y apellido',
        ),
        validator: (value) {
          _SigninState._emailValidator = value.toString();
          if (value == null || value.isEmpty) {
            return 'Por favor, ingrese su nombre';
          }
          _SigninState._errorLogin = '';
          return null;
        },
      ),
    );
  });
}

Widget _emailTextField() {
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
          _SigninState._emailValidator = value.toString();
          if (value == null || value.isEmpty || !value.contains('@')) {
            return 'Por favor, ingrese un correo valido';
          }
          _SigninState._errorLogin = '';
          return null;
        },
      ),
    );
  });
}

Widget _repeatEmailTextField() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'ejemplo@correo.com',
          labelText: 'Confirmacion de Correo electronico',
        ),
        validator: (value) {
          _SigninState._emailValidator = value.toString();
          if (value == null || value.isEmpty || !value.contains('@')) {
            return 'Por favor, ingrese un correo valido';
          }
          _SigninState._errorLogin = '';
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
          _SigninState._passwordValidator = value.toString();
          if (value == null || value.isEmpty) {
            return 'Por favor, ingrese su contraseña';
          }
          _SigninState._errorLogin = '';
          return null;
        },
      ),
    );
  });
}

Widget _repeatPasswordTextField() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.password),
          hintText: 'Contraseña',
          labelText: 'Confirmar Contraseña',
        ),
        validator: (value) {
          _SigninState._passwordValidator = value.toString();
          if (value == null || value.isEmpty) {
            return 'Por favor, ingrese su contraseña';
          }
          _SigninState._errorLogin = '';
          return null;
        },
      ),
    );
  });
}
