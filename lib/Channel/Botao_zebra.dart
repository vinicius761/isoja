import 'package:flutter/services.dart';

class ZebraButtonChannel {
  static const EventChannel _eventChannel = EventChannel(
    'com.example.isoja/zebra_button',
  );

  static Stream<String> get onButtonPressed =>
      _eventChannel.receiveBroadcastStream().map((event) => event as String);
}
