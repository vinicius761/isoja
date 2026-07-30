import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isoja/Channel/ZebraChannel.dart';
import 'package:isoja/Components/ToastMessageComponent.dart';
import 'package:isoja/Utils/EpcToSerialFormater.dart';
import 'package:isoja/Utils/ZebraScannerService.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// IMPORT CORRETO: Removido o 'package:sqflite/sqflite.dart' que gerava o conflito
import 'package:sqflite_sqlcipher/sqflite.dart';

class ZebraScannerController {
  final Function(Map<String, dynamic> tag)? onRfidRead;
  final Function(Map<String, dynamic> barcodeData)? onBarcodeRead;
  final Function()? onConfigLoaded;

  bool isRfid = false;
  bool isBarcode = false;
  bool isDialogOpen = false;
  List<dynamic> tags = [];

  final int rfMode;
  final int tari;
  final String mode;
  final int rssiMin;
  final int defaultPowerIndex;

  Database? _database;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ZebraScannerController({
    this.onRfidRead,
    this.onBarcodeRead,
    this.onConfigLoaded,
    this.rfMode = 2,
    this.tari = 25,
    this.mode = "cadrolinho",
    this.rssiMin = -60,
    this.defaultPowerIndex = 10,
  }) {
    _initHardwareConfig();
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('db_alg.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final path = join(documentsDir.path, dbName);

    final exists = await databaseExists(path);

    if (!exists) {
      try {
        final byteData = await rootBundle.load('assets/$dbName');
        final buffer = byteData.buffer.asUint8List();
        await File(path).writeAsBytes(buffer, flush: true);
        print("Banco copiado do assets com sucesso para $path");
      } catch (e) {
        throw Exception("Erro ao copiar banco: $e");
      }
    } else {
      print("Banco já existente no dispositivo.");
    }

    String? senha = await _secureStorage.read(key: 'db_password');
    if (senha == null) {
      senha = base64UrlEncode(utf8.encode(DateTime.now().toIso8601String()));
      await _secureStorage.write(key: 'db_password', value: senha);
    }

    return await openDatabase(path, password: senha, version: 1);
  }

  Future<bool> _validarSequenciaLona(String codigoEtiqueta) async {
    try {
      final db = await database;

      final List<Map<String, dynamic>> resultado = await db.query(
        'MARCA_LONA',
        where: '? LIKE SEQUENCIA || \'%\'',
        whereArgs: [codigoEtiqueta],
      );

      print(
        "Código testado: $codigoEtiqueta | Encontrado no banco: ${resultado.isNotEmpty}",
      );
      return resultado.isNotEmpty;
    } catch (e) {
      print("Erro ao consultar tabela MARCA_LONA com LIKE: $e");
      return false;
    }
  }

  Future<void> _initHardwareConfig() async {
    try {
      bool conectado = await ZebraChannel.isConnected();

      if (conectado) {
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

  void startListeningScanner() {
    ZebraScannerService.start(
      profileName: "cotton",
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
          // CORREÇÃO: Extrai os dados puros do barcode de forma segura
          final barcodeData = map['tagId'] ?? map['barcodeData'] ?? '';
          final barcodeMap = _buildBarcodeMap(barcodeData);
          if (onBarcodeRead != null) onBarcodeRead!(barcodeMap);
          break;
      }
    }
  }

  Future<void> _processRfidTag(Map<String, dynamic> rawTag) async {
    final formattedTag = _buildTagMap(rawTag['tagId'], rawTag['rssi']);
    String codigoEtiqueta = epcToSerialFormater(formattedTag['tagId'] ?? '');

    if (codigoEtiqueta.isNotEmpty) {
      bool lonaValida = await _validarSequenciaLona(codigoEtiqueta);

      if (lonaValida) {
        isRfid = true;
        tags = [formattedTag];
        if (onRfidRead != null) onRfidRead!(formattedTag);
      } else {
        ToastMessageComponent.warning(
          "Lona Inválida '${epcToSerialFormater(rawTag['tagId'])}' não permitida.",
        );
        print(
          "Leitura rejeitada. Prefixo do código '$codigoEtiqueta' ausente na MARCA_LONA.",
        );
      }
    } else {
      ToastMessageComponent.warning("Código de etiqueta vazio.");
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
    if (barcodeData['tagId'].length == 11) {
      final res = {
        'tagId': barcodeData['tagId'],
        'rssi': '0',
        'status': '0',
        'codigo': barcodeData['tagId'],
        'type': 'barcode',
      };

      return res;
    }

    final res = {
      'tagId': barcodeData['tagId'],
      'rssi': '0',
      'status': '0',
      'codigo': epcToSerialFormater(barcodeData['tagId']),
      'type': 'barcode',
    };
    return res;
  }
}
