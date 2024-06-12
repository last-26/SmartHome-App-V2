import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "SmartHomeDB.db";
  static final _databaseVersion = 1;

  static final table = 'sensor_data';

  static final columnId = '_id';
  static final columnTemperature = 'temperature';
  static final columnSound = 'sound';
  static final columnBrightness = 'brightness';
  static final columnUserCount = 'user_count';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  late Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTemperature REAL NOT NULL,
            $columnSound REAL NOT NULL,
            $columnBrightness REAL NOT NULL,
            $columnUserCount INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<Map<String, dynamic>> queryLatest() async {
    Database db = await instance.database;
    List<Map> results = await db.query(table, orderBy: "$columnId DESC", limit: 1);
    if (results.isNotEmpty) {
      return results.first as Map<String, dynamic>;
    }
    return {};
  }

  Future<void> clearTable() async {
    Database db = await instance.database;
    await db.delete(table);
  }
}
