// ignore_for_file: file_names, non_constant_identifier_names, annotate_overrides
import 'package:flutter/foundation.dart';

class SensorValuesProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String humidity = '';
  String temperature = '';
  String distance = '';

  String get Humidity => humidity;
  String get Temperature => temperature;
  String get Distance => distance;

  void SetData(String datos) {
    final data = datos.split('-');
    temperature = data[0];
    humidity = data[1];
    distance = data[2];
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('humidity', humidity));
  }
}
