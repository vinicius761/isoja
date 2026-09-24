import 'dart:async';
import 'package:isoja/Channel/ZebraChannel.dart';
import 'package:flutter/material.dart';

// Definição de tipos de retorno para as funções de callback
typedef OnTagScanned = void Function(Map<String, dynamic> tag);
typedef OnBarcodeScanned = void Function(Map<String, dynamic> barcode);

class ZebraScannerService {
  static StreamSubscription? _subscription;
  static List<Map<String, dynamic>> _currentTags = [];
  static bool _triggerPressed = false;

  /// Inicia a escuta do scanner de forma genérica
  static void start({
    required String profileName,
    required OnTagScanned onTagFound,
    required OnBarcodeScanned onBarcodeFound,
  }) {
    // 1. Ativa o perfil desejado (ex: "SOJA")
    // ZebraChannel.activateProfile(profileName);

    _subscription?.cancel(); // Evita múltiplas inscrições
    _currentTags.clear();

    _subscription = ZebraChannel.scanStream.listen((data) {
      final Map<String, dynamic> map = Map<String, dynamic>.from(data);
      if (map['tagId'] == null &&
          map['type'] != 'trigger' &&
          map['type'] != 'toast')
        return;

      switch (map['type']) {
        case 'tag':
          _handleRfidTag(map, onTagFound);
          break;

        case 'trigger':
          _handleTrigger(map);
          break;

        case 'Barcode':
          onBarcodeFound(map);
          break;

        case 'toast':
          debugPrint('Zebra Toast: ${map['message']}');
          break;
      }
    });
  }

  /// Encaminha cada leitura RFID para o fluxo da tela.
  /// A deduplicacao fica no RfidSequencialProcessor.
  static void _handleRfidTag(Map<String, dynamic> map, OnTagScanned callback) {
    final tagId = map['tagId'];
    final rssi = map['rssi'] ?? 0;
    if (tagId == null) return;

    callback({
      'tagId': tagId,
      'rssi': rssi,
      'status': map['status'] ?? '0',
      'type': 'tag',
    });
  }

  static void _handleTrigger(Map<String, dynamic> map) {
    final pressed = map['pressed'] ?? false;
    if (_triggerPressed != pressed) {
      _triggerPressed = pressed;
      if (!_triggerPressed) _currentTags.clear(); // Limpa ao soltar o gatilho
    }
  }

  static void stop() {
    _subscription?.cancel();
    _subscription = null;
  }
}

typedef OnTagProcessada = void Function(Map<String, dynamic> tag);

class RfidSequencialProcessor {
  final List<Map<String, dynamic>> _fila = [];
  final Set<String> _idsProcessados = {};
  bool _processando = false;

  final Duration delay;

  RfidSequencialProcessor({this.delay = const Duration(milliseconds: 500)});

  /// Adiciona nova tag para processamento sequencial
  void adicionar(Map<String, dynamic> tag, OnTagProcessada callback) {
    final tagId = tag['tagId'];

    if (tagId == null) return;

    // evita duplicação
    if (_idsProcessados.contains(tagId)) return;

    _idsProcessados.add(tagId);

    _fila.add({
      'tagId': tagId,
      'rssi': tag['rssi'],
      'type': tag['type'] ?? 'RFID',
    });

    _processar(callback);
  }

  /// Processa fila (1 por vez)
  void _processar(OnTagProcessada callback) async {
    if (_processando || _fila.isEmpty) return;

    _processando = true;

    // 🔥 opcional: ordenar por proximidade (RSSI melhor primeiro)
    _fila.sort((a, b) {
      final rssiA = a['rssi'] ?? -999;
      final rssiB = b['rssi'] ?? -999;
      return rssiB.compareTo(rssiA);
    });

    final tag = _fila.removeAt(0);

    print("🔥 SEQUENCIAL: ${tag['tagId']}");

    callback(tag);

    await Future.delayed(delay);

    _processando = false;

    _processar(callback);
  }

  /// Limpa tudo (ex: ao soltar gatilho)
  void reset() {
    _fila.clear();
    _idsProcessados.clear();
    _processando = false;
  }
}
