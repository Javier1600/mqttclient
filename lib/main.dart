// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mqttclient/helpers/sensorsValuesProvider.dart';
import 'package:mqttclient/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(AppState());
  });
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SensorValuesProvider(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Basurero Inteligente',
        initialRoute: 'home',
        routes: Routes.routes,
      ),
    );
  }
}
