import 'dart:async';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:isoja/Components/ToastMessage.component.dart';
import 'package:isoja/Controllers/Controller_config.dart';
import 'package:isoja/Controllers/Rfid_Controller.dart';
import 'package:isoja/Utils/ZebraScannerController.dart';
import 'package:isoja/Utils/iniciarConexaoPistola.dart';

class LeitorRfidController extends GetxController {
  late ZebraScannerController zebraController;
  final RfidService rfidService = RfidService();
  final configController = Get.find<ControllerConfig>();

  StreamSubscription? rfidSubscription;

  final ultimaTagLida = ''.obs;
  final isDialogOpen = false.obs;

  // Variáveis reativas de conexão
  final isConectado = false.obs;
  final isConnecting = false.obs;
  final isGlobalLoading = false.obs;

  // Getters para compatibilidade com a View
  RxBool get isConnected => isConectado;
  RxBool get isConectando => isConnecting;

  List<Map<String, dynamic>> tags = [];

  @override
  void onInit() {
    super.onInit();
    _iniciarLeitor();
  }

  void _iniciarLeitor() {
    _conectarZebraScanner();

    rfidSubscription?.cancel();
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
        tags = [tagFormatada];
        _tratarLeituraRfid(tagFormatada);
      },
      onBarcodeRead: (dadosBarcode) async {
        tags = [dadosBarcode];
        _tratarLeituraBarcode(dadosBarcode);
      },
    );
  }

  /// Lógica idêntica ao handleConexao do HomeController
  Future<void> handleConexao() async {
    isConnecting.value = true;
    isGlobalLoading.value = true;

    try {
      await Future.delayed(const Duration(milliseconds: 100));

      if (isConectado.value) {
        await reconectaConexaoPistola();
      } else {
        await iniciarConexaoPistola();
        isConectado.value = true;
      }
    } catch (e) {
      isConectado.value = false;
      ToastMessageComponent.info('Erro ao conectar: $e');
    } finally {
      await Future.delayed(const Duration(seconds: 3));
      isConnecting.value = false;
      isGlobalLoading.value = false;
    }
  }

  void resetConexao() {
    isConectado.value = false;
  }

  void setDialogOpen(bool value) {
    isDialogOpen.value = value;
    zebraController.isDialogOpen = value;
  }

  void _tratarLeituraRfid(Map<String, dynamic> tagData) {
    final epc = tagData['codigo'] ?? tagData['tagId'] ?? tagData.toString();
    ultimaTagLida.value = "RFID: $epc";
    zebraController.startListeningScanner();
  }

  void _tratarLeituraBarcode(Map<String, dynamic> barcodeData) {
    final barcode =
        barcodeData['codigo'] ?? barcodeData['tagId'] ?? barcodeData.toString();
    ultimaTagLida.value = "Barcode: $barcode";
    zebraController.startListeningScanner();
  }

  @override
  void onClose() {
    rfidSubscription?.cancel();
    rfidSubscription = null;
    rfidService.disconnect();
    zebraController.stopListeningScanner();
    zebraController.dispose();
    super.onClose();
  }
}
