import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:isoja/Model/User.model.dart';
import 'package:isoja/Utils/DatabaseHelper.util.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<bool> insertUserBatch(List<UserModel> users) async {
    try {
      final db = await _dbHelper.database;
      final batch = db.batch();

      for (var user in users) {
        batch.insert('USER', {
          'ID_USER': user.idUser,
          'USER': user.user,
          'NOME': user.nome,
          'EMAIL': user.email,
          'SENHA': user.senha,
          'ID_PROTHEUS': user.idProtheus,
          'ADMIN': user.isAdmin,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
      print("Sucesso ao inserir lote de users no SQLite");

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<UserModel>> fetchAllUsers() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('USER');

    return maps
        .map(
          (item) => UserModel(
            idUser: item['ID_USER']?.toString() ?? '',
            nome: item['NOME']?.toString() ?? '',
            user: item['USER']?.toString() ?? '',
            email: item['EMAIL']?.toString() ?? '',
            senha: item['SENHA']?.toString() ?? '',
            idProtheus: item['ID_PROTHEUS']?.toString() ?? '',
            isAdmin: item['ADMIN']?.toString() ?? '0',
            dataCriacao: item['DATA_CRIACAO'].toString(),
          ),
        )
        .toList();
  }

  Future<UserModel?> findByUserAndSenha(String user, String senha) async {
    final db = await _dbHelper.database;

    final bytes = utf8.encode(senha);

    final senhaCriptografada = sha256.convert(bytes).toString();
    final List<Map<String, dynamic>> maps = await db.query(
      'USER',
      where: 'USER = ? AND SENHA = ?',
      whereArgs: [user, senhaCriptografada],
    );

    if (maps.isNotEmpty) {
      final item = maps.first;
      return UserModel(
        idUser: item['ID_USER']?.toString() ?? '',
        nome: item['NOME']?.toString() ?? '',
        user: item['USER']?.toString() ?? '',
        email: item['EMAIL']?.toString() ?? '',
        senha: item['SENHA']?.toString() ?? '',
        idProtheus: item['ID_PROTHEUS']?.toString() ?? '',
        isAdmin: item['ADMIN']?.toString() ?? '0',
        dataCriacao: item['DATA_CRIACAO']?.toString() ?? '',
      );
    }
    return null;
  }

  Future<int> updateUser(UserModel user) async {
    final db = await _dbHelper.database;
    return await db.update(
      'USER',
      {
        'NOME': user.nome,
        'USER': user.user,
        'EMAIL': user.email,
        'SENHA': user.senha,
        'ID_PROTHEUS': user.idProtheus,
        'ADMIN': user.isAdmin,
      },
      where: 'ID_USER = ?',
      whereArgs: [user.idUser],
    );
  }

  Future<int> deleteUser(String idUser) async {
    final db = await _dbHelper.database;
    return await db.delete('USER', where: 'ID_USER = ?', whereArgs: [idUser]);
  }

  Future<void> clearUserTable() async {
    final db = await _dbHelper.database;
    await db.delete('USER');
  }
}
