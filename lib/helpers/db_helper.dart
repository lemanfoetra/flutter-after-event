import 'package:sqflite/sqflite.dart' as Sql;
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await Sql.getDatabasesPath();
    return await Sql.openDatabase(
      Path.join(dbPath, 'after_event.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE event (id TEXT PRIMARY KEY, judul TEXT, tanggal DATE, latitude REAL,  longitude REAL, alamat TEXT )",
        );
        await db.execute(
          "CREATE TABLE list_photo (id TEXT PRIMARY KEY, event_id TEXT, path_image TEXT )",
        );
      },
      version: 1,
    );
  }

  static Future<int> insert(String tableName, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    return await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getListEvent() async {
    final db = await DBHelper.database();
    return await db.rawQuery(
      "SELECT A.*, (SELECT path_image FROM list_photo WHERE event_id = A.id LIMIT 1 ) AS path_image FROM event A ORDER BY A.tanggal DESC ",
    );
  }

  static Future<int> deleteEventWithId(String id) async {
    final db = await DBHelper.database();
    return await db.delete(
      'event',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> truncateTable(String table) async {
    final db = await DBHelper.database();
    await db.delete(table);
  }

  static Future<List<Map<String, dynamic>>> getEventWithId(
      String idEvent) async {
    final db = await DBHelper.database();
    return await db.query(
      'event',
      where: "id = ?",
      whereArgs: [idEvent],
    );
  }

  static Future<List<Map<String, dynamic>>> getPhotosEventWithIdEvent(
      String idEvent) async {
    final db = await DBHelper.database();
    return await db.query(
      'list_photo',
      where: "event_id = ?",
      whereArgs: [idEvent],
    );
  }

  /// DELETE EVENT DATA
  static Future<void> deleteEvent(String idEvent) async {
    final db = await DBHelper.database();
    // DELETE list photo in list_photo table
    await db.delete(
      'list_photo',
      where: "event_id = ?",
      whereArgs: [idEvent],
    );
    // DELETE in event table
    await db.delete(
      'event',
      where: "id = ?",
      whereArgs: [idEvent],
    );
  }
}
