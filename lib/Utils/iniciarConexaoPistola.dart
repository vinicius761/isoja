import 'package:isoja/Channel/ZebraChannel.dart';
import 'package:isoja/Components/ToastMessageComponent.dart';
import 'package:isoja/Controllers/Rfid_Controller.dart';

final RfidService _rfidService = RfidService();

Future<void> iniciarConexaoPistola() async {
  try {
    _rfidService.connect();
    await ZebraChannel.setRfConfig(
      powerIndex: 300,
      rfMode: 2,
      tari: 25,
      mode: "cadrolinho",
      rssiMin: -60,
    );
    ToastMessageComponent.success('Pistola conectada com sucesso!');
  } catch (e) {
    ToastMessageComponent.error('Falha ao conectar pistola: $e');
  }
}

Future<void> reconectaConexaoPistola() async {
  try {
    await ZebraChannel.reconnect();

    await ZebraChannel.setRfConfig(
      powerIndex: 300,
      rfMode: 2,
      tari: 25,
      mode: "cadrolinho",
      rssiMin: -60,
    );
    ToastMessageComponent.success('Reconectado a pistola com sucesso!');
  } catch (e) {
    ToastMessageComponent.error('Falha ao conectar pistola: $e');
  }
}
