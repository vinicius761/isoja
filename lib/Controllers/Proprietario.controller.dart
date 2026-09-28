import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:isoja/Api/Proprietario.api.dart';
import 'package:isoja/Components/ToastMessage.component.dart';
import 'package:isoja/Model/Proprietario.model.dart';

class ProprietarioController extends GetxController {
  final api = ProprietarioApi();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telefone = TextEditingController();
  TextEditingController cpfCnpj = TextEditingController();

  RxList<dynamic> proprietarios = [].obs;

  @override
  void onInit() async {
    await buscar();
    super.onInit();
  }

  void salvar() async {
    if (formKey.currentState!.validate()) {
      try {
        final res = await api.criarProprietario(
          Proprietario(
            nome: nome.text,
            cpfCnpj: cpfCnpj.text,
            telefone: telefone.text,
            email: email.text,
          ),
        );
        ToastMessageComponent.info("${res.body}");
      } catch (e) {
        ToastMessageComponent.error(e.toString());
      }
    }
  }

  Future<void> buscar() async {
    try {
      final res = await api.buscaProprietario();

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
                (item) => Proprietario.fromJson(item as Map<String, dynamic>),
              )
              .toList();

      proprietarios.value = listaProprietarios;

      print("Total de proprietários carregados: ${listaProprietarios.length}");
    } catch (e) {
      ToastMessageComponent.error(e.toString());
    }
  }
}
