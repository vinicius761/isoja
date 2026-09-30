import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:isoja/Api/Acoplamento.api.dart';
import 'package:isoja/Components/ToastMessage.component.dart';
import 'package:isoja/Model/Acoplamento.model.dart';
import 'package:isoja/Model/CavaloMecanico.Model.dart';

class AcoplamentoController extends GetxController {
  final api = AcoplamentoApi();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxString idCarreta = ''.obs;
  RxString idCavalo = ''.obs;

  RxList<dynamic> proprietarios = [].obs;

  @override
  void onInit() async {
    await buscar();
    super.onInit();
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

      print("Total de proprietários carregados: ${listaProprietarios.length}");
    } catch (e) {
      ToastMessageComponent.error(e.toString());
    }
  }
}
