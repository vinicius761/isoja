import 'dart:async';
import 'package:flutter/services.dart';

class RfidService {
  static final RfidService _instance = RfidService._internal();
  factory RfidService() => _instance;
  RfidService._internal();

  final EventChannel _rfidEventChannel = const EventChannel(
    'com.zebra.rfid/events',
  );

  StreamSubscription? _subscription;

  dynamic _lastEvent;
  dynamic get lastEvent => _lastEvent;

  final StreamController<dynamic> _controller = StreamController.broadcast();

  Stream<dynamic> get stream => _controller.stream;

  Timer? _timeoutTimer;

  // 🔥 CONNECT ARRUMADO
  void connect() {
    if (_subscription != null) {
      print('RFID já conectado');
      return;
    }

    print('Conectando ao RFID...');

    _subscription = _rfidEventChannel.receiveBroadcastStream().listen(
      (event) {
        final map = Map<String, dynamic>.from(event);

        // ✅ salva último evento
        _lastEvent = map;

        // ✅ envia pra UI
        _controller.add(map);

        // ❌ REMOVE reconexão automática (isso quebrava seu fluxo)
        _timeoutTimer?.cancel();
      },
      onError: (error) {
        print('Erro no RFID: $error');
        disconnect();
      },
      onDone: () {
        print('Stream encerrada');
        disconnect();
      },
    );
  }

  void disconnect() {
    print('Desconectando RFID...');
    _subscription?.cancel();
    _subscription = null;
    _timeoutTimer?.cancel();
  }

  bool get isConnected => _subscription != null;
}
