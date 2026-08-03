import 'package:isoja/Model/Veiculo.model.dart';
import 'package:isoja/Utils/DatabaseHelper.util.dart';
import 'package:sqflite/sqflite.dart';

class VeiculoRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<bool> insertVeiculoBatch(List<VeiculoModel> veiculos) async {
    try {
      final db = await _dbHelper.database;
      final batch = db.batch();

      for (var veiculo in veiculos) {
        batch.insert(
          'VEICULOS',
          veiculo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
      print("Sucesso ao inserir lote de Veículos no SQLite");
      return true;
    } catch (e) {
      print("Erro ao inserir lote de Veículos no SQLite: $e");
      return false;
    }
  }

  Future<List<VeiculoModel>> fetchAllVeiculo() async {
    try {
      final db = await _dbHelper.database;
      final List<Map<String, dynamic>> maps = await db.query('VEICULOS');

      return maps.map((item) => VeiculoModel.fromMap(item)).toList();
    } catch (e) {
      print("Erro ao buscar Veículos no SQLite: $e");
      return [];
    }
  }

  Future<void> clearVeiculoModelTable() async {
    final db = await _dbHelper.database;
    await db.delete('VEICULOS');
  }
}
