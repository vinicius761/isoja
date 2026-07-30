import 'package:get/get.dart';
import 'package:isoja/Channel/ZebraChannel.dart';
import 'package:isoja/Utils/ZebraScannerController.dart';

class PecasController extends GetxController {
  late ZebraScannerController _zebraScanner;

  final RxString codigoLido = ''.obs;

  @override
  void onInit() {
    super.onInit();
    print(">>> [SCANNER] Iniciando escuta do ZebraChannel...");

    _inicializarScanner();

    ZebraChannel.scanStream.listen(
      (data) {
        print(">>> DADO LIDO PELO SCANNER: $data");
      },
      onError: (error) {
        print(">>> ERRO NO SCANNER: $error");
      },
    );
  }

  void _inicializarScanner() {
    _zebraScanner = ZebraScannerController(
      onBarcodeRead: (barcodeData) {
        _tratarLeituraBarcode(barcodeData);
      },
      onConfigLoaded: () {
        print("Configurações do scanner Zebra carregadas com sucesso!");
      },
    );

    _zebraScanner.startListeningScanner();
  }

  void _tratarLeituraBarcode(Map<String, dynamic> barcodeData) {
    print("barcode ${barcodeData}");
    // String codigo = barcodeData['codigo'] ?? barcodeData['tagId'] ?? '';

    // if (codigo.isNotEmpty) {
    //   codigoLido.value = codigo;
    //   print("Código de barras / QR Code lido: $codigo");
    // }
  }
}
