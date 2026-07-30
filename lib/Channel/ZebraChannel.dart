import 'dart:async';
import 'package:flutter/services.dart';

class ZebraChannel {
  static const MethodChannel _method = MethodChannel('zebra_method_channel');
  static const EventChannel _event = EventChannel('zebra_data_channel');
  static const MethodChannel _configrfid = MethodChannel(
    'com.zebra.rfid/methods',
  );

  static final StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>.broadcast();

  static StreamSubscription? _nativeSubscription;

  /// Ativa o perfil no DataWedge
  static Future<void> activateProfile(String profileName) async {
    await _method.invokeMethod('activateProfile', {'profileName': profileName});
  }

  /// Enviar configs de RFID para o Java (RFD40)
  static Future<void> setRfConfig({
    required int powerIndex,
    required int rfMode,
    required int tari,
    String? mode,
    int? rssiMin,
  }) async {
    await _configrfid.invokeMethod('setRfConfig', {
      "powerIndex": powerIndex,
      "rfMode": rfMode,
      "tari": tari,
      "mode": mode ?? "default",
      "rssiMin": rssiMin ?? -999,
    });
  }

  static Future<void> reconnect() async {
    await _configrfid.invokeMethod('reconnect');
  }

  /// Stream pública segura para múltiplas telas
  static Stream<Map<String, dynamic>> get scanStream {
    // Garante que o listener nativo é iniciado só uma vez
    _nativeSubscription ??= _event
        .receiveBroadcastStream()
        .map((event) => Map<String, dynamic>.from(event))
        .listen((data) {
          _controller.add(data); // repassa para todas as telas
        });

    return _controller.stream;
  }

  /// Fecha tudo ao encerrar o app (opcional)
  static Future<void> dispose() async {
    await _nativeSubscription?.cancel();
    await _controller.close();
    _nativeSubscription = null;
  }

  /// Verifica se o leitor RFID está conectado (Zebra)
  static Future<bool> isConnected() async {
    try {
      final bool result = await _configrfid.invokeMethod('isConnected');
      return result;
    } catch (e) {
      return false;
    }
  }
}
