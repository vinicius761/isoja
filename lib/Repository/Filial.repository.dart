import 'package:isoja/Model/Filial.model.dart';
import 'package:isoja/Utils/DatabaseHelper.util.dart';
import 'package:sqflite/sqflite.dart';

class FilialRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<bool> insertFilialBatch(List<Filial> filiais) async {
    try {
      final db = await _dbHelper.database;
      final batch = db.batch();

      for (var filial in filiais) {
        batch.insert(
          'FILIAL',
          filial.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
      print("Sucesso ao inserir lote de filiais no SQLite");
      return true;
    } catch (e) {
      print("Erro ao inserir lote de filiais no SQLite: $e");
      return false;
    }
  }

  Future<List<Filial>> fetchAllFiliais() async {
    try {
      final db = await _dbHelper.database;
      final List<Map<String, dynamic>> maps = await db.query('FILIAL');

      return maps.map((item) => Filial.fromMap(item)).toList();
    } catch (e) {
      print("Erro ao buscar filiais no SQLite: $e");
      return [];
    }
  }

  Future<void> clearFilialTable() async {
    final db = await _dbHelper.database;
    await db.delete('FILIAL');
  }
}
