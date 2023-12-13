import 'package:g4i_deposito/database/database_helper.dart';
import 'package:g4i_deposito/database/tables/user_table.dart';
import 'package:g4i_deposito/models/user_model.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';
import 'package:sqflite/sqflite.dart';

class UserCrud {
  Future<void> createTableUsers(Database db) async {
    await db.execute("DROP TABLE IF EXISTS $tableUsers");
    await db.execute('CREATE TABLE IF NOT EXISTS $tableUsers('
        '$fieldUsers TEXT'
        ')');
  }

  Future<bool> insertUserInDb(UserModel user) async {
    Database db = await DatabaseHelper().database;
    try {
      await db.insert(tableUsers, UserModel.toDb(user));
      return true;
    } catch (e) {
      print("ERRO INSERÇÃO BANCO DE DADOS");
      return false;
    }
  }

  // Future<List<UserModel>> selectAllUsers() async {
  //   Database db = await DatabaseHelper().database;
  //   try {
  //     List<UserModel> returnList = [];
  //     List<MapSD> response = await db.rawQuery("SELECT * FROM $tableUsers");
  //     response.forEach((element) => returnList.add(UserModel.fromDb(element)));
  //     return returnList;
  //   } catch (e) {
  //     print("ERRO SELECT ALL BANCO DE DADOS");
  //     return [];
  //   }
  // }

  Future<List<String>> selectAllUsers() async {
    Database db = await DatabaseHelper().database;
    try {
      List<String> returnList = [];
      List<MapSD> response =
          await db.rawQuery("SELECT $fieldUsers FROM $tableUsers");
      response.forEach((element) => returnList.add(element[fieldUsers]));
      return returnList;
    } catch (e) {
      print("ERRO SELECT EMAILS BANCO DE DADOS");
      return [];
    }
  }

  // Future<List<UserModel>> selectUserFromEmailandId(
  //     String email, String senha) async {
  //   Database db = await DatabaseHelper().database;
  //   try {
  //     List<UserModel> returnList = [];
  //     List<MapSD> response = await db.query(tableUsers,
  //         where: "$fieldUsersEmail = ? AND $fieldUsersPass = ?",
  //         whereArgs: [email, senha]);
  //     response.forEach((element) => returnList.add(UserModel.fromDb(element)));
  //     return returnList;
  //   } catch (e) {
  //     print("ERRO SELECT BANCO DE DADOS");
  //     return [];
  //   }
  // }

  Future<void> deleteUser(String email) async {
    Database db = await DatabaseHelper().database;
    try {
      await db.delete(tableUsers, where: "$fieldUsers = ?", whereArgs: [email]);
    } catch (e) {
      print("ERRO DELETE BANCO DE DADOS");
    }
  }

  // Future<void> updateUserSituation(MapSD newUser, String email) async {
  //   Database db = await DatabaseHelper().database;
  //   try {
  //     db.update(tableUsers, newUser,
  //         where: "$fieldUsersEmail = ?", whereArgs: [email]);
  //   } catch (e) {
  //     print("ERRO UPDATE BANCO DE DADOS");
  //   }
  // }

  Future<void> deleteAllUsers() async {
    Database db = await DatabaseHelper().database;
    try {
      db.execute("DELETE FROM $tableUsers");
    } catch (e) {
      print("ERRO DELETE ALL FUNCIONARIOS");
    }
  }
}
