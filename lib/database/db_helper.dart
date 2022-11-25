import 'package:path/path.dart' as syspath;
import 'package:sqflite/sqflite.dart' as sql;

import '../data/models/note.dart';

class DBHelper {
  static const String _tableName = "notes";
  static Future<sql.Database> init() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      syspath.join(dbPath, "notes.db"),
      onCreate: (db, version) {
        return db.execute(
          """
        CREATE TABLE $_tableName (
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

  static Future<List<Note>> getData() async {
    final sqlDB = await DBHelper.init();
    final List<Map<String, dynamic>> queryResult =
        await sqlDB.query(_tableName);

    return queryResult.map((e) => Note.fromMap(e)).toList();
  }

  static Future<void> deleteNote({String? noteId}) async {
    final sqlDB = await DBHelper.init();
    await sqlDB
        .delete(DBHelper._tableName, where: "id = ?", whereArgs: [noteId]);
  }

  static Future<int> updateNote({Note? note}) async {
    var sqlDB = await DBHelper.init();
    var result = await sqlDB.update(DBHelper._tableName, note!.toMap(),
        where: "id = ?", whereArgs: [note.id]);
    return result;
  }
}
