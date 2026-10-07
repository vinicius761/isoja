import 'package:isoja/Model/Talhao.model.dart';
import 'package:isoja/Utils/DatabaseHelper.util.dart';
import 'package:sqflite/sqflite.dart';

class TalhaoRepository {
  final DatabaseHelper _dbHelper;

  TalhaoRepository({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  Future<Database> get _db async => await _dbHelper.database;

  Future<void> save(Talhao talhao) async {
    final db = await _db;
    await db.insert(
      'TALHAO',
      talhao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Object?>> insertBatch(List<Talhao> talhoes) async {
    final db = await _db;
    final batch = db.batch();

    for (final talhao in talhoes) {
      batch.insert(
        'TALHAO',
        talhao.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    return await batch.commit(noResult: false);
  }

  Future<void> saveAll(List<Talhao> talhoes) async {
    final db = await _db;
    final batch = db.batch();
    for (final talhao in talhoes) {
      batch.insert(
        'TALHAO',
        talhao.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Talhao>> getAll() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('TALHAO');
    return maps.map((map) => Talhao.fromMap(map)).toList();
  }

  Future<Talhao?> getById({
    required String filial,
    required String safra,
    required String fazenda,
    required String talhao,
  }) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'TALHAO',
      where:
          'NN3_FILIAL = ? AND NN3_SAFRA = ? AND NN3_FAZ = ? AND NN3_TALHAO = ?',
      whereArgs: [filial, safra, fazenda, talhao],
    );

    if (maps.isNotEmpty) {
      return Talhao.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete({
    required String filial,
    required String safra,
    required String fazenda,
    required String talhao,
  }) async {
    final db = await _db;
    return await db.delete(
      'TALHAO',
      where:
          'NN3_FILIAL = ? AND NN3_SAFRA = ? AND NN3_FAZ = ? AND NN3_TALHAO = ?',
      whereArgs: [filial, safra, fazenda, talhao],
    );
  }

  /// Limpa todos os dados da tabela
  Future<void> clearTable() async {
    final db = await _db;
    await db.delete('TALHAO');
  }
}
