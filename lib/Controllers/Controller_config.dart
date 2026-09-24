import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Model/ConfigScanner.model.dart';
import 'package:isoja/Utils/DatabaseHelper.util.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class ControllerConfig extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxString cadastroRolinho = ''.obs;
  RxString romaneio = ''.obs;
  RxString Embloca = ''.obs;
  RxString checklistRomaneio = ''.obs;
  RxString filaBeneficiamento = ''.obs;
  RxString lote = ''.obs;

  RxString ipBalanca = ''.obs;
  RxString portaBalanca = ''.obs;
  RxBool loading = false.obs;

  RxString classificacao = ''.obs;

  Rx<Configuracoes> configuracao = Configuracoes().obs;

  @override
  void onInit() {
    super.onInit();
    carregarDadosNosControllers();
  }

  Future<void> carregarDadosNosControllers() async {
    final config = await buscarConfiguracao();

    if (config != null) {
      cadastroRolinho.value = config.cadroLinho ?? '';
      romaneio.value = config.romaneio ?? '';
      Embloca.value = config.Embloca ?? '';
      checklistRomaneio.value = config.checkRomaneio ?? '';
      filaBeneficiamento.value = config.filaBeneficiamento ?? '';
      lote.value = config.cadroLinhoLote ?? '';
      classificacao.value = config.classificacao ?? '';
    }
  }

  Future<void> salvarConfiguracoes() async {
    loading.value = true;
    try {
      final db = await DatabaseHelper.instance.database;

      final config = Configuracoes(
        id: 1,
        cadroLinho: cadastroRolinho.value,
        romaneio: romaneio.value,
        Embloca: Embloca.value,
        checkRomaneio: checklistRomaneio.value,
        filaBeneficiamento: filaBeneficiamento.value,
        classificacao: classificacao.value,
        cadroLinhoLote: lote.value,
      );

      final dados = config.toMap();

      int linhasAfetadas = await db.update(
        'CONFIGURACOES',
        dados,
        where: 'id = ?',
        whereArgs: [1],
      );

      if (linhasAfetadas == 0) {
        int idInserido = await db.insert(
          'CONFIGURACOES',
          dados,
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
        print("Primeiro registro criado com sucesso! ID: $idInserido");
      } else {
        print(
          "Registro único atualizado com sucesso! Linhas afetadas: $linhasAfetadas",
        );
      }

      configuracao.value = config;

      Get.back();

      Get.snackbar(
        "Sucesso",
        "Configurações salvas!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      loading.value = false;
    } catch (e) {
      loading.value = false;
      print("Erro ao salvar: $e");

      Get.snackbar(
        "Erro",
        "Falha ao salvar configurações",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<Configuracoes?> buscarConfiguracao() async {
    try {
      final db = await DatabaseHelper.instance.database;

      final resultado = await db.query(
        'CONFIGURACOES',
        where: 'id = ?',
        whereArgs: [1],
        limit: 1,
      );

      if (resultado.isNotEmpty) {
        return Configuracoes.fromMap(resultado.first);
      }

      return null;
    } catch (e) {
      print("Erro ao buscar config: $e");
      return null;
    }
  }
}
