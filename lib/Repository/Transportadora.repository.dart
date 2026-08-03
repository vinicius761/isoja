import 'package:isoja/Model/Transportadora.model.dart';
import 'package:isoja/Utils/DatabaseHelper.util.dart';
import 'package:sqflite/sqflite.dart';

class TransportadoraRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<bool> insertTransportadoraBatch(
    List<TransportadoraModel> transportadoras,
  ) async {
    try {
      final db = await _dbHelper.database;
      final batch = db.batch();

      for (var veiculo in transportadoras) {
        batch.insert(
          'TRANSPORTADORA',
          veiculo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
      print("Sucesso ao inserir lote de Transportadoras no SQLite");
      return true;
    } catch (e) {
      print("Erro ao inserir lote de Transportadoras no SQLite: $e");
      return false;
    }
  }

  Future<List<TransportadoraModel>> fetchAllTransportadora() async {
    try {
      final db = await _dbHelper.database;
      final List<Map<String, dynamic>> maps = await db.query('TRANSPORTADORA');

      return maps.map((item) => TransportadoraModel.fromMap(item)).toList();
    } catch (e) {
      print("Erro ao buscar Transportadoras no SQLite: $e");
      return [];
    }
  }

  Future<void> clearTransportadoraModelTable() async {
    final db = await _dbHelper.database;
    await db.delete('TRANSPORTADORA');
  }
}
