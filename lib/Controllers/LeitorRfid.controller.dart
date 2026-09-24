import 'dart:async';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:isoja/Controllers/Controller_config.dart';
import 'package:isoja/Controllers/Rfid_Controller.dart';
import 'package:isoja/Utils/ZebraScannerController.dart';

class LeitorRfidController extends GetxController {
  late ZebraScannerController zebraController;
  final RfidService rfidService = RfidService();
  final configController = Get.find<ControllerConfig>();

  StreamSubscription? rfidSubscription;

  final ultimaTagLida = ''.obs;
  final isDialogOpen = false.obs;

  List<Map<String, dynamic>> tags = [];

  @override
  void onInit() {
    super.onInit();
    _iniciarLeitor();
  }

  void _iniciarLeitor() {
    _conectarZebraScanner();
    rfidSubscription?.cancel();

    // Ouve a transmissão de eventos físicos do scanner
    rfidSubscription = rfidService.stream.listen((event) {
      zebraController.onEventReceived(event);
    }, onError: (error) {});

    zebraController.startListeningScanner();
  }

  void _conectarZebraScanner() {
    zebraController = ZebraScannerController(
      configController: configController,
      selectPowerField: (config) => config.cadroLinho,
      mode: "NOVA_TELA",
      onRfidRead: (tagFormatada) async {
        // Callback acionado quando uma Tag RFID é lida
        tags = [tagFormatada];
        _tratarLeituraRfid(tagFormatada);
      },
      onBarcodeRead: (dadosBarcode) async {
        // Callback acionado quando um Código de Barras é lido
        tags = [dadosBarcode];
        _tratarLeituraBarcode(dadosBarcode);
      },
    );
  }

  void setDialogOpen(bool value) {
    isDialogOpen.value = value;
    zebraController.isDialogOpen = value;
  }

  // Recebe os dados do RFID
  void _tratarLeituraRfid(Map<String, dynamic> tagData) {
    // Exemplo: pega o código EPC lido
    final epc = tagData['epc'] ?? tagData.toString();
    ultimaTagLida.value = "RFID: $epc";

    print(epc);
    // Reinicia escuta do leitor se necessário
    zebraController.startListeningScanner();
  }

  // Recebe os dados do Código de Barras
  void _tratarLeituraBarcode(Map<String, dynamic> barcodeData) {
    final barcode = barcodeData['barcode'] ?? barcodeData.toString();
    ultimaTagLida.value = "Barcode: $barcode";
    print(barcode);

    zebraController.startListeningScanner();
  }

  @override
  void onClose() {
    // Sempre encerre a escuta para não manter o leitor ocupado em background
    rfidSubscription?.cancel();
    rfidSubscription = null;
    zebraController.stopListeningScanner();
    zebraController.dispose();
    super.onClose();
  }
}
