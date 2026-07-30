import 'dart:io';
import 'package:isoja/Model/ConfigScanner.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';

class ControllerConfig extends GetxController {
  static final FlutterSecureStorage _secureStorage =
      const FlutterSecureStorage();

  static Database? _database;

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

  // ✅ NOVO CAMPO ADICIONADO
  RxString classificacao = ''.obs;

  Rx<Configuracoes> configuracao = Configuracoes().obs;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('db_alg.db');
    return _database!;
  }

  @override
  void onInit() {
    super.onInit();
    database.then((_) => carregarDadosNosControllers());
  }

  Future<void> carregarDadosNosControllers() async {
    final config = await buscarConfiguracao();

    print(config!.toMap());

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
      final db = await database;

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
      final db = await database;

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

  Future<Database> _initDB(String dbName) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, dbName);

    final exists = await databaseExists(path);

    if (!exists) {
      final byteData = await rootBundle.load('assets/$dbName');
      final buffer = byteData.buffer.asUint8List();
      await File(path).writeAsBytes(buffer, flush: true);
    }

    String? senha = await _secureStorage.read(key: 'db_password');

    if (senha == null) {
      senha = DateTime.now().millisecondsSinceEpoch.toString();
      await _secureStorage.write(key: 'db_password', value: senha);
    }

    return openDatabase(path, password: senha, version: 1);
  }
}
