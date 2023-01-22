import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class ThemeDB {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'theme.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_theme(id TEXT PRIMARY KEY, colorID TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    final db = await ThemeDB.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await ThemeDB.database();
    return db.query(table);
  }
}
