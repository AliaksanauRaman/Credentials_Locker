import 'package:sqflite/sqflite.dart';

import './database.service.dart';

import '../models/pin/pin.dart';

class PinsDbService {
  static Future insertPin(Pin pin) async {
    final database = await DatabaseService.instance.database;

    if (database == null) {
      throw Exception("Database is not defined!");
    }

    return database.insert(
      "pins",
      pin.toDbRecord(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getAllPins() async {
    final database = await DatabaseService.instance.database;

    if (database == null) {
      throw Exception("Database is not defined!");
    }

    final List<Map<String, dynamic>> maps = await database.query('pins');

    return maps;
  }
}
