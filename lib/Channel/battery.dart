import 'package:flutter/services.dart';

class BatteryChannel {
  final EventChannel _event = const EventChannel('isoja/rfid');

  Stream get stream => _event.receiveBroadcastStream().cast();
}
