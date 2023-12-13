import 'package:g4i_deposito/database/crud/user_crud.dart';
import 'package:g4i_deposito/models/user_model.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper with UserCrud{

  DatabaseHelper.internal();
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  
  Database? db;

  Future<Database> get database async {
    if (db != null) {
      return db!;
    }
    else {
      db = await initDb();
      return db!;
    }
  }

  Future <Database> initDb() async {
    final databasePath = await getApplicationDocumentsDirectory();
    const String dbName = "refeitorio_definitivo.db";
    final path = join(databasePath.path, dbName);
    return await openDatabase(path, version: 1, onCreate: (database, newerVersion) async =>  await createCompleteDb(database));
  }


  Future<void> createCompleteDb(Database database) async {
    await createTableUsers(database);
  }


  Future<void> deleteCompleteDb () async {
    await deleteAllUsers();
  }



}