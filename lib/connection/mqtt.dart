// ignore_for_file: avoid_print

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqttclient/helpers/sensorsValuesProvider.dart';

class MQTTConnect {
  MqttServerClient? _client;
  final String _identifier;
  final String _host;
  final String _topicSub;
  final String _topicPub;
  final SensorValuesProvider _currentState;

  MQTTConnect(
      {required String host,
      required String topicSub,
      required String topicPub,
      required String identifier,
      required SensorValuesProvider state})
      : _identifier = identifier,
        _host = host,
        _topicSub = topicSub,
        _topicPub = topicPub,
        _currentState = state;

  void initializeMQTTClient() {
    _client = MqttServerClient(_host, _identifier);
    _client!.port = 1883;
    _client!.keepAlivePeriod = 20;
    _client!.onDisconnected = onDisconnected;
    _client!.secure = false;
    _client!.logging(on: false);

    _client!.onConnected = onConnected;
    _client!.onSubscribed = onSubscribed;
    _client!.setProtocolV311();

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing5
        .withWillQos(MqttQos.atLeastOnce);
    _client!.connectionMessage = connMess;

    print('Cliente Mosquitto inicializado!!!');
  }

  void connect() async {
    assert(_client != null);
    try {
      print('Tratando de conectar el cliente Mosquitto....');
      await _client!.connect();
    } on Exception catch (e) {
      print('Excepción capturada - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client!.disconnect();
  }

  void publish(String message) {
    print(_client?.connectionStatus!.state.toString());
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(_topicPub, MqttQos.exactlyOnce, builder.payload!);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
  }

  /// The successful connect callback
  void onConnected() {
    print('EXAMPLE::Mosquitto client connected....');
    _client!.subscribe(_topicSub, MqttQos.atLeastOnce);
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      // ignore: avoid_as
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

      // final MqttPublishMessage recMess = c![0].payload;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _currentState.SetData(pt);
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }
}
