import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Api/Acoplamento.api.dart';
import 'package:isoja/Components/ToastMessage.component.dart';
import 'package:isoja/Model/Acoplamento.model.dart';
import 'package:isoja/Controllers/Rfid.controller.dart';

class AcoplamentoController extends GetxController {
  final api = AcoplamentoApi();
  final rfidService = RfidService();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxString idCarreta = ''.obs;
  RxString idCavalo = ''.obs;
  TextEditingController RFID = TextEditingController();
  RxString RFIDRead = ''.obs;

  RxBool isRfidActive = false.obs;

  RxList<dynamic> proprietarios = [].obs;
  StreamSubscription? _rfidSubscription;

  @override
  void onInit() async {
    await buscar();
    iniciarRfid();
    super.onInit();
  }

  @override
  void onClose() {
    pararRfid();
    super.onClose();
  }

  void iniciarRfid() {
    rfidService.connect();
    isRfidActive.value = rfidService.isConnected;

    _rfidSubscription = rfidService.stream.listen((event) {
      _processarTagRfid(event);
    });
  }

  void pararRfid() {
    _rfidSubscription?.cancel();
    rfidService.disconnect();
    isRfidActive.value = false;
  }

  void _processarTagRfid(dynamic event) {
    // if (event == null) return;

    final String? tagRead = event['tag'] ?? event['epc'] ?? event['id'];

    print("TESTE TESTE ${event}");

    if (tagRead != null && tagRead.isNotEmpty) {
      ToastMessageComponent.info("Tag lida: $tagRead");
      RFID.text = event['tagId'];
      // TODO: Insira aqui a sua lógica para associar a tag ao Cavalo ou à Carreta.
      // Exemplo:
      // final cavaloEncontrado = cavaloController.cavalos.firstWhereOrNull((c) => c.rfidTag == tagRead);
      // if (cavaloEncontrado != null) {
      //   idCavalo.value = cavaloEncontrado.id.toString();
      // }
    }
  }

  void salvar() async {
    if (formKey.currentState!.validate()) {
      try {
        final res = await api.criarAcoplamento(
          Acoplamento(
            idCarreta: int.parse(idCarreta.value),
            idCavalo: int.parse(idCavalo.value),
          ),
        );
        ToastMessageComponent.info("Cadastrada com sucesso!");
        Get.back();
      } catch (e) {
        ToastMessageComponent.error(e.toString());
      }
    }
  }

  Future<void> buscar() async {
    try {
      final res = await api.buscaAcoplamento();

      if (res.status.hasError) {
        ToastMessageComponent.error(
          'Erro ao buscar proprietários: ${res.statusText}',
        );
        return;
      }

      final List<dynamic> bodyList = res.body;
      final listaProprietarios =
          bodyList
              .map((item) => Acoplamento.fromJson(item as Map<String, dynamic>))
              .toList();

      proprietarios.value = listaProprietarios;
    } catch (e) {
      ToastMessageComponent.error(e.toString());
    }
  }
}
