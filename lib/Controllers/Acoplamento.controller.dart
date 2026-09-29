import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:isoja/Api/CavaloMecanico.api.dart';
import 'package:isoja/Components/ToastMessage.component.dart';
import 'package:isoja/Model/CavaloMecanico.Model.dart';

class AcoplamentoController extends GetxController {
  final api = CavaloMecanicoApi();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController placa = TextEditingController();
  TextEditingController renavam = TextEditingController();
  TextEditingController modelo = TextEditingController();
  TextEditingController marca = TextEditingController();
  TextEditingController anoFabricacao = TextEditingController();
  RxString idProprietario = '1'.obs;

  RxList<dynamic> proprietarios = [].obs;

  @override
  void onInit() async {
    await buscar();
    super.onInit();
  }

  void salvar() async {
    if (formKey.currentState!.validate()) {
      try {
        final res = await api.criarCavaloMecanico(
          CavaloMecanico(
            placa: placa.text,
            renavam: renavam.text,
            modelo: modelo.text,
            marca: marca.text,
            anoFabricacao: int.parse(anoFabricacao.text),
            idProprietario: int.parse(idProprietario.value),
          ),
        );
        ToastMessageComponent.info(
          "Cadastrada com sucesso ${res.body['modelo']}",
        );
      } catch (e) {
        ToastMessageComponent.error(e.toString());
      }
    }
  }

  Future<void> buscar() async {
    try {
      final res = await api.buscaCavaloMecanico();

      if (res.status.hasError) {
        ToastMessageComponent.error(
          'Erro ao buscar proprietários: ${res.statusText}',
        );
        return;
      }

      final List<dynamic> bodyList = res.body;
      final listaProprietarios =
          bodyList
              .map(
                (item) => CavaloMecanico.fromJson(item as Map<String, dynamic>),
              )
              .toList();

      proprietarios.value = listaProprietarios;

      print("Total de proprietários carregados: ${listaProprietarios.length}");
    } catch (e) {
      ToastMessageComponent.error(e.toString());
    }
  }
}
