import 'dart:async';
import 'package:isoja/Channel/ZebraChannel.dart';
import 'package:isoja/Components/ToastMessage.component.dart';
import 'package:isoja/Controllers/Controller_config.dart';
import 'package:isoja/Model/ConfigScanner.model.dart';
import 'package:isoja/Utils/EpcToSerialFormater.dart';
import 'package:isoja/Utils/ZebraScannerService.dart';

class ZebraScannerController {
  final Function(Map<String, dynamic> tag)? onRfidRead;
  final Function(Map<String, dynamic> barcodeData)? onBarcodeRead;
  final Function()? onConfigLoaded;

  bool isRfid = false;
  bool isBarcode = false;
  bool isDialogOpen = false;
  List<dynamic> tags = [];

  final ControllerConfig configController;
  final String? Function(Configuracoes config)? selectPowerField;

  final int rfMode;
  final int tari;
  final String mode;
  final int rssiMin;
  final int defaultPowerIndex;

  ZebraScannerController({
    required this.configController,
    this.onRfidRead,
    this.onBarcodeRead,
    this.onConfigLoaded,
    required this.selectPowerField,
    this.rfMode = 2,
    this.tari = 25,
    this.mode = "cadrolinho",
    this.rssiMin = -60,
    this.defaultPowerIndex = 10,
  }) {
    _initHardwareConfig();
  }

  // ===========================================================================
  // MÉTODO PÚBLICO: VALIDAÇÃO COMPLETA DE SEQUÊNCIA DE LONA (DESATIVADO)
  // ===========================================================================

  /// Valida se o [codigoEtiqueta] (ou a tag bruta) pertence a uma sequência permitida.
  ///
  /// **Atenção:** A validação via banco de dados foi comentada.
  /// O método agora ignora a consulta na tabela MARCA_LONA e sempre retorna `true`.
  Future<bool> validarSequenciaTag(String rawOrFormattedTag) async {
    /* 
    try {
      if (rawOrFormattedTag.trim().isEmpty) {
        print("Validação rejeitada: Código de etiqueta está vazio.");
        return false;
      }

      final String codigoEtiqueta = epcToSerialFormater(rawOrFormattedTag);

      if (codigoEtiqueta.isEmpty) {
        print("Validação rejeitada: Formatação resultou em string vazia.");
        return false;
      }

      final db = await DatabaseHelper.instance.database;

      final List<Map<String, dynamic>> resultado = await db.query(
        'MARCA_LONA',
        where: '? LIKE SEQUENCIA || \'%\'',
        whereArgs: [codigoEtiqueta],
      );

      final bool isValid = resultado.isNotEmpty;
      print(
        "Código Testado: '$codigoEtiqueta' (Original: '$rawOrFormattedTag') | Sequência Válida: $isValid",
      );

      return isValid;
    } catch (e) {
      print("Erro ao consultar a tabela MARCA_LONA: $e");
      return false;
    }
    */

    return true;
  }

  // ===========================================================================
  // CONFIGURAÇÃO DO HARDWARE ZEBRA
  // ===========================================================================

  Future<void> _initHardwareConfig() async {
    try {
      bool conectado = await ZebraChannel.isConnected();

      if (conectado) {
        final Configuracoes? config =
            await configController.buscarConfiguracao();

        String? campoPotencia;
        if (config != null && selectPowerField != null) {
          campoPotencia = selectPowerField!(config);
        }

        print(
          "Configuração principal carregada no construtor. Potência injetada por tela: $campoPotencia",
        );

        final valor = int.tryParse(campoPotencia ?? '299') ?? defaultPowerIndex;

        await ZebraChannel.setRfConfig(
          powerIndex: 299,
          rfMode: rfMode,
          tari: tari,
          mode: mode,
          rssiMin: rssiMin,
        );

        if (onConfigLoaded != null) onConfigLoaded!();
      }
    } catch (e) {
      ToastMessageComponent.warning(
        "Erro ao inicializar configurações da Zebra no construtor: $e",
      );
    }
  }

  // ===========================================================================
  // LISTENERS E EVENTOS DO SCANNER
  // ===========================================================================

  void startListeningScanner() {
    ZebraScannerService.start(
      profileName: "isoja",
      onTagFound: (melhorTag) {
        _processRfidTag(melhorTag);
      },
      onBarcodeFound: (dados) {
        final barcodeMap = _buildBarcodeMap(dados);
        if (onBarcodeRead != null) onBarcodeRead!(barcodeMap);
      },
    );
  }

  Future<void> onEventReceived(dynamic event) async {
    final Map<String, dynamic> map = Map<String, dynamic>.from(event);

    if (!isDialogOpen) {
      switch (map['type']) {
        case 'tag':
          await _processRfidTag(map);
          break;

        case 'barcode':
          isBarcode = true;
          final barcodeData = map['tagId'] ?? map['barcodeData'] ?? '';
          final barcodeMap = _buildBarcodeMap(barcodeData);
          if (onBarcodeRead != null) onBarcodeRead!(barcodeMap);
          break;
      }
    }
  }

  void stopListeningScanner() {
    try {
      ZebraScannerService.stop();
    } catch (e) {
      print("Erro ao parar ZebraScannerService: $e");
    }
  }

  void dispose() {
    stopListeningScanner();
  }

  // ===========================================================================
  // PROCESSAMENTO DE TAGS E MAPEAMENTO
  // ===========================================================================

  Future<void> _processRfidTag(Map<String, dynamic> rawTag) async {
    final formattedTag = _buildTagMap(rawTag['tagId'], rawTag['rssi']);
    final String tagRawId = rawTag['tagId'] ?? '';

    if (tagRawId.isEmpty) {
      ToastMessageComponent.warning("Código de etiqueta vazio.");
      return;
    }

    final bool lonaValida = await validarSequenciaTag(tagRawId);

    if (lonaValida) {
      isRfid = true;
      tags = [formattedTag];
      if (onRfidRead != null) onRfidRead!(formattedTag);
    } else {
      final String formattedDisplay = epcToSerialFormater(tagRawId);
      ToastMessageComponent.warning(
        "Lona Inválida '$formattedDisplay' não permitida.",
      );
      print("Leitura de RFID rejeitada. Tag fora da sequência padrão.");
    }
  }

  Map<String, dynamic> _buildTagMap(dynamic tagId, dynamic rssi) {
    final formattedId = epcToSerialFormater(tagId);
    return {
      'tagId': tagId,
      'rssi': rssi,
      'status': '0',
      'codigo': formattedId,
      'type': 'tag',
    };
  }

  Map<String, dynamic> _buildBarcodeMap(dynamic barcodeData) {
    final String rawData =
        barcodeData is Map
            ? (barcodeData['tagId'] ?? '')
            : barcodeData.toString();

    if (rawData.length == 11) {
      return {
        'tagId': rawData,
        'rssi': '0',
        'status': '0',
        'codigo': rawData,
        'type': 'barcode',
      };
    }

    return {
      'tagId': rawData,
      'rssi': '0',
      'status': '0',
      'codigo': epcToSerialFormater(rawData),
      'type': 'barcode',
    };
  }
}
