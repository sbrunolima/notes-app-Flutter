import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class TextDB {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_notes(id TEXT PRIMARY KEY, title TEXT, textContent TEXT, dateTime TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    final db = await TextDB.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await TextDB.database();
    return db.query(table);
  }
}
