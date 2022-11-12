import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as syspath;

import '../models/note.dart';

class DBHelper {
  static const tableName = "notes";
  static Future<sql.Database> init() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      syspath.join(dbPath, "notes.db"),
      onCreate: (db, version) {
        return db.execute(
          """
        CREATE TABLE $tableName (
          id TEXT PRIMARY KEY, 
          title TEXT,
          somethings TEXT
        );
        """,
        );
      },
      version: 1,
    );
  }

  static Future<void> insertData(
      {String? table, Map<String, dynamic>? data}) async {
    final sqlDB = await DBHelper.init();
    sqlDB.insert(table!, data!);
  }

  static Future<List<Note>> getData({String? tableName}) async {
    final sqlDB = await DBHelper.init();
    if (tableName != null) {
      final List<Map<String, dynamic>> queryResult =
          await sqlDB.query(tableName);

      return queryResult.map((e) => Note.fromMap(e)).toList();
    }
    return [];
  }

  static Future<void> deleteNote({String? noteId}) async {
    final sqlDB = await DBHelper.init();
    await sqlDB
        .delete(DBHelper.tableName, where: "id = ?", whereArgs: [noteId]);
  }

  static Future<int> updateNote({Note? note}) async {
    var sqlDB = await DBHelper.init();
    var result = await sqlDB.update(DBHelper.tableName, note!.toMap(),
        where: "id = ?", whereArgs: [note.id]);
    return result;
  }
}
