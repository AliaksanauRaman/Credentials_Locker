import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static const _databaseName = 'clocker.db';
  static const _databaseVersion = 1;

  static Database? _database;

  DatabaseService._internal();

  static final DatabaseService instance = DatabaseService._internal();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    final databasePath = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(
      databasePath,
      onCreate: _onCreate,
      version: _databaseVersion,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS pins (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        value CHAR(4) NOT NULL,
        is_active INTEGER NOT NULL,
        created_at INTEGER NOT NULL
      )
    """);
  }
}
