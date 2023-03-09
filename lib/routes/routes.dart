import 'package:flutter/material.dart';
import 'package:mqttclient/pages/home.dart';
import 'package:mqttclient/pages/initialPage.dart';
import 'package:mqttclient/pages/login.dart';
import 'package:mqttclient/pages/sensorLayout.dart';
import 'package:mqttclient/pages/signin.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (_) => const MyHomePage(),
    'login': (_) => const LoginPage(),
    'signin': (_) => const Signin(),
    'main': (_) => const Home(),
    'sensors': (_) => const SensorLayout(),
  };
}
