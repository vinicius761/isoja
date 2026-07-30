import 'package:isoja/Model/UserFilial.model.dart';
import 'package:isoja/Utils/DatabaseHelper.util.dart';
import 'package:sqflite/sqflite.dart';

class UserFilialRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<bool> insertUserFilialBatch(List<UserFilialModel> vinculos) async {
    try {
      final db = await _dbHelper.database;
      final batch = db.batch();

      for (var vinculo in vinculos) {
        batch.insert(
          'USER_FILIAL',
          vinculo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
      print("Sucesso ao inserir lote de usersFilial no SQLite");

      return true;
    } catch (e) {
      print("Erro ao inserir lote em USER_FILIAL: $e");
      return false;
    }
  }

  Future<List<UserFilialModel>> fetchAll() async {
    try {
      final db = await _dbHelper.database;
      final List<Map<String, dynamic>> maps = await db.query('USER_FILIAL');

      // Mapeia os dados utilizando o construtor fromMap da sua model
      return maps.map((item) => UserFilialModel.fromMap(item)).toList();
    } catch (e) {
      print("Erro ao buscar dados de USER_FILIAL: $e");
      return [];
    }
  }

  Future<List<UserFilialModel>> userFilialRepo(String codUser) async {
    try {
      final db = await _dbHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'USER_FILIAL',
        where: 'COD_USER = ?',
        distinct: true,
        whereArgs: [codUser],
      );

      return maps.map((item) => UserFilialModel.fromMap(item)).toList();
    } catch (e) {
      print("Erro ao buscar filiais do usuário $codUser: $e");
      return [];
    }
  }

  Future<void> clearTable() async {
    final db = await _dbHelper.database;
    await db.delete('USER_FILIAL');
  }
}
