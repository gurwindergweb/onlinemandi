import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;
  static final DBProvider _instance = new DBProvider.internal();
  factory DBProvider() =>_instance;
  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  DBProvider.internal();
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "OMdatabase.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Weight ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "unitId INTEGER,"
          "depends INTEGER,"
          "multiplier REAL"
          ")");
      await db.execute("CREATE TABLE Unit ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "sname TEXT,"
          "status INTEGER"
          ")");
    });
  }
  Future<List> getAllRecords(String dbTable) async {
    var dbClient = await database;
    var result = await dbClient.rawQuery("SELECT * FROM $dbTable");
    return result.toList();
  }
  getweight(id) async {
    var dbClient = await database;
    // var result = await dbClient.rawQuery("SELECT * FROM $dbTable");
    var result = await  dbClient.query("Weight", where: "id = ?", whereArgs: [id]);
    return result;
  }
  Future getUnit(id) async {
    var dbClient = await database;
    // var result = await dbClient.rawQuery("SELECT * FROM $dbTable");
    var result = await  dbClient.query("Unit", where: "id = ?", whereArgs: [id]);
    return result;
  }
}