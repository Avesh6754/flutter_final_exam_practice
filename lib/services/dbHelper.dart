import 'dart:developer';

import 'package:flutter_final_exam_practice/modal/InventoryModal.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDataBase() as Database?;
      return _database;
    }
  }

  Future<void> initDataBase() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, 'demo.db');

    await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE item (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, quantity INTEGER, supplier TEXT, time TEXT,category TEXT )');
    });
  }

  Future<void> insertData(Inventorymodal item) async {
    try {
      Database? db = await database;
      await db!.insert('item',toMap(item),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      log('Not Insert');
    }
  }

  Future<void> updateData(Inventorymodal item, int id) async {
    Database? db = await database;
    await db!.update('item', toMap(item), where: 'id=?', whereArgs: [id]);
  }

  Future<void> deleteData(int id) async {
    Database? db = await database;
    await db!.delete('item', where: 'id=?', whereArgs: [id]);
  }

  Future<List<Map<String, Object?>>> fetchData() async {
    Database? db = await database;
    try {
      final data = await db!.query('item');

      return data;
    } catch (e) {
      return [];
    }
  }
}
