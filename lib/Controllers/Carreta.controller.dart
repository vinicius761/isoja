import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:isoja/Api/Carreta.api.dart';
import 'package:isoja/Components/ToastMessage.component.dart';
import 'package:isoja/Model/Carreta.model.dart';

class CarretaController extends GetxController {
  final api = CarretaApi();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController placa = TextEditingController();
  TextEditingController renavam = TextEditingController();
  TextEditingController eixos = TextEditingController();
  TextEditingController capacidadeCarga = TextEditingController();
  TextEditingController anoFabricacao = TextEditingController();
  RxString idProprietario = ''.obs;
  RxString tipo = ''.obs;

  RxList<Carreta> carretas = <Carreta>[].obs;

  final List<String> tiposCarreta = [
    'Graneleira',
    'Baú',
    'Sider',
    'Prancha',
    'Caçamba',
    'Tanque',
    'Frigorífica',
    'Porta-Contêiner',
    'Carga Aberta (Grade Baixa)',
    'Cegonheira',
  ];

  @override
  void onInit() async {
    await buscar();
    super.onInit();
  }

  void salvar() async {
    if (formKey.currentState!.validate()) {
      try {
        final res = await api.criarCavaloMecanico(
          Carreta(
            placa: placa.text,
            renavam: renavam.text,
            tipo: tipo.value,
            eixos: int.parse(eixos.text),
            capacidadeCargaKg: double.parse(capacidadeCarga.text),
            anoFabricacao: int.parse(anoFabricacao.text),
            idProprietario: int.parse(idProprietario.value),
          ),
        );
        ToastMessageComponent.info("Cadastrada com sucesso.");
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
      final listaCarretas =
          bodyList
              .map((item) => Carreta.fromJson(item as Map<String, dynamic>))
              .toList();

      carretas.value = listaCarretas;

      print("Total de proprietários carregados: ${listaCarretas.length}");
    } catch (e) {
      ToastMessageComponent.error(e.toString());
    }
  }
}
