import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:o_soja/dao/producao_dao.dart';
import 'package:o_soja/model/producao_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:math';
import 'dart:convert';
// Importe suas tabelas e DAOs aqui

part 'database.g.dart';

@DriftDatabase(tables: [Producoes], daos: [ProducoesDao])
class AppDatabase extends _$AppDatabase {
  // Singleton
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase() => _instance;
  
  // Construtor privado chamando a conexão criptografada
  AppDatabase._internal() : super(_openEncryptedConnection());

  @override
  int get schemaVersion => 1;
}

// --- A MÁGICA DA CRIPTOGRAFIA ACONTECE AQUI ---
LazyDatabase _openEncryptedConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'agro_secure.db')); // Mudei o nome pra garantir

    // Busca a senha segura (veja o passo 3 abaixo)
    final senhaBanco = await _obterSenhaSegura();

    return NativeDatabase(
      file,
      // Aqui ativamos o SQLCipher
      setup: (rawDb) {
        // Define a chave de criptografia ANTES de qualquer leitura
        rawDb.execute("PRAGMA key = '$senhaBanco';");
        
        // Opcional: Verifica se a chave funcionou (retorna 'ok')
        // final result = rawDb.select('SELECT count(*) FROM sqlite_master'); 
      },
    );
  });
}

// Função auxiliar para gerenciar a senha (NUNCA deixe hardcoded "123456")


Future<String> _obterSenhaSegura() async {
  const storage = FlutterSecureStorage();
  
  // Tenta ler a chave existente
  String? key = await storage.read(key: 'db_key');
  
  // Se não existir (primeira vez que o app roda), gera uma nova aleatória
  if (key == null) {
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(255));
    key = base64UrlEncode(values); // Gera uma string tipo "aX7d9...="
    
    // Salva no Cofre do Celular (Keychain no iOS / Keystore no Android)
    await storage.write(key: 'db_key', value: key);
  }
  
  return key;
}