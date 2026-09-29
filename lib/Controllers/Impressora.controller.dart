import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Model/ConfigBalanca.model.dart';
import 'package:isoja/Utils/DatabaseHelper.util.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class ControllerConfigImpressora extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController ipBalanca = TextEditingController();
  TextEditingController portaBalanca = TextEditingController();
  RxBool loading = false.obs;

  Rx<ConfiguracaoBalanca> configuracao = ConfiguracaoBalanca().obs;

  @override
  void onInit() {
    super.onInit();
    carregarDadosNosControllers();
  }

  Future<void> carregarDadosNosControllers() async {
    final config = await buscarConfiguracao();

    if (config != null) {
      ipBalanca.text = config.ipBalanca ?? '';
      portaBalanca.text = config.portBalanca ?? '';
    }
  }

  Future<void> salvarConfiguracoes() async {
    loading.value = true;
    try {
      final db = await DatabaseHelper.instance.database;

      final config = ConfiguracaoBalanca(
        id: 1,
        ipBalanca: ipBalanca.text,
        portBalanca: portaBalanca.text,
      );

      final dados = config.toMap();

      int linhasAfetadas = await db.update(
        'CONFIGURACAO_IMPRESSORA',
        dados,
        where: 'ID = ?',
        whereArgs: [1],
      );

      if (linhasAfetadas == 0) {
        int idInserido = await db.insert(
          'CONFIGURACAO_IMPRESSORA',
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

  Future<ConfiguracaoBalanca?> buscarConfiguracao() async {
    try {
      final db = await DatabaseHelper.instance.database;

      final resultado = await db.query(
        'CONFIGURACAO_IMPRESSORA',
        where: 'ID = ?',
        whereArgs: [1],
        limit: 1,
      );

      if (resultado.isNotEmpty) {
        return ConfiguracaoBalanca.fromMap(resultado.first);
      }

      return null;
    } catch (e) {
      print("Erro ao buscar config: $e");
      return null;
    }
  }
}
