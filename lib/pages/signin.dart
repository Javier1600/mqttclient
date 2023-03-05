// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print, unused_field, prefer_final_fields, unnecessary_null_comparison
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/cancelButton.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  final List<QueryDocumentSnapshot> users;
  const Signin(this.users, {Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  static List<QueryDocumentSnapshot> _users = [];
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerE1 = TextEditingController();
  final TextEditingController _controllerE2 = TextEditingController();
  final TextEditingController _controllerP1 = TextEditingController();
  final TextEditingController _controllerP2 = TextEditingController();

  @override
  void dispose() {
    _controllerUser.dispose();
    _controllerE1.dispose();
    _controllerE2.dispose();
    _controllerP1.dispose();
    _controllerP2.dispose();
    super.dispose();
  }

  void clearTextFields() {
    _controllerUser.clear();
    _controllerE1.clear();
    _controllerE2.clear();
    _controllerP1.clear();
    _controllerP2.clear();
  }

  bool addHelper(List<QueryDocumentSnapshot> vUsers) {
    bool validator = false;
    for (var user in vUsers) {
      if (user['email'] != _controllerUser.text) {
        print("...");
        validator = true;
      } else {
        validator = false;
      }
    }
    if (validator) {
      print('....');
      final data = {
        'nombre': _controllerUser.text,
        'email': _controllerE1.text,
        'password': _controllerP1.text
      };
      addDataToFirestore('users', data);
      errorAlert("Registro exitoso!", "Se ha registrado de forma correcta");
    } else {
      print("El correo ingresado ya esta registrado");
    }
    return validator;
  }

  Future<void> addDataToFirestore(
      String collectionName, Map<String, dynamic> data) async {
    try {
      print(".....");
      final CollectionReference collection =
          FirebaseFirestore.instance.collection(collectionName);
      final docRef =
          collection.doc(); // Genera un ID aleatorio para el nuevo registro
      await docRef.set(data);
      print('Data added to Firestore successfully');
      clearTextFields();
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

  bool Validator() {
    bool validator = true;
    if (_controllerUser.text.isEmpty ||
        _controllerE1.text.isEmpty ||
        _controllerE2.text.isEmpty ||
        _controllerP1.text.isEmpty ||
        _controllerP2.text.isEmpty) {
      errorAlert("Error", "Ingrese valores a todos los campos");
      validator = false;
    } else {
      if (_controllerE1.text == _controllerE2.text) {
        if (_controllerP1.text == _controllerP2.text) {
          validator = true;
          errorAlert("Error", "Verifique su correo y contraseña");
        } else {
          errorAlert("Error", "Verifique su correo y contraseña");
          validator = false;
        }
      } else {
        validator = false;
        errorAlert("Error", "Los correos ingresados no coinciden");
      }
    }
    return validator;
  }

  void getUsers() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    QuerySnapshot users = await collectionReference.get();
    if (users.docs.isNotEmpty) {
      _users = users.docs;
    }
  }

  void errorAlert(String title, String error) {
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
  void initState() {
    super.initState();
    _users = widget.users;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                  height: 120.0,
                  width: 100,
                  child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/3135/3135768.png'),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: _controllerUser,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Nombre Apellido',
                        labelText: 'Nombre y apellido',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese su nombre';
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
                      controller: _controllerE1,
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
                      controller: _controllerE2,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'ejemplo@correo.com',
                        labelText: 'Confirmacion de Correo electronico',
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
                      controller: _controllerP1,
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
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: _controllerP2,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.password),
                        hintText: 'Contraseña',
                        labelText: 'Confirmar Contraseña',
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
                Center(
                    child: Row(
                  children: [
                    SizedBox(
                      width: 40.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print("presionado");
                          print(Validator());
                          if (Validator()) {
                            print(".");
                            if (addHelper(_users)) {
                              print("..");
                              getUsers();
                              for (var user in _users) {
                                print(user.data());
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 50),
                            backgroundColor: Colors.blue),
                        child: Text(
                          "Registrarte",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        )),
                    SizedBox(
                      width: 10.0,
                    ),
                    CancelButton(),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
