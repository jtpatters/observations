import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:observations/dimension.dart';
import 'package:observations/observation.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String dimensionTable = 'dim_table';
  String colId = 'id';
  String colName = 'name';
  String observationTable = 'obs_table';
  String colDim = 'dim_id';
  String colQuality = 'quality';
  String colComments = 'comments';
  String colDate = 'datetime';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'dim.db';

    var dimensionDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    print("database opened");
    return dimensionDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $dimensionTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT)');
    await db.execute(
        'CREATE TABLE $observationTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDim INTEGER, $colQuality TEXT, $colComments TEXT, ' +
            'FOREIGN KEY($colDim) REFERENCES $dimensionTable($colId))');
    print("create db called");
  }

  Future<List<Map<String, dynamic>>> getDimensionMapList() async {
    Database db = await this.database;

    var result = await db.query(dimensionTable, orderBy: '$colName ASC');
    return result;
  }

  Future<int> insertDimension(Dimension dim) async {
    print("inserting dimension");
    Database db = await this.database;
    var result = await db.insert(dimensionTable, dim.toMap());
    return result;
  }

  Future<int> insertObservation(Observation obs) async {
    print("inserting observation");
    Database db = await this.database;
    var result = await db.insert(observationTable, obs.toMap());
    return result;
  }

  Future<int> updateDimension(Dimension dim) async {
    var db = await this.database;
    var result = await db.update(dimensionTable, dim.toMap(),
        where: '$colId = ?', whereArgs: [dim.id]);
    return result;
  }

  Future<int> deleteAllDimensions() async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $dimensionTable');
    return result;
  }

  Future<int> deleteDimension(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $dimensionTable WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $dimensionTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Dimension>> getDimensionList() async {
    var dimensionMapList =
        await getDimensionMapList(); // Get 'Map List' from database
    int count =
        dimensionMapList.length; // Count the number of map entries in db table
    List<Dimension> dimensionList = <Dimension>[];
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      dimensionList.add(Dimension.fromMapObject(dimensionMapList[i]));
    }
    return dimensionList;
  }
}
