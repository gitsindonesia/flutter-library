import 'package:gits_inspector/gits_inspector.dart';
import 'package:sqflite/sqflite.dart';

abstract class InspectorService {
  static const String _table = 'inspector';
  static const String _id = 'id';
  static const String _request = 'request';
  static const String _response = 'response';
  static const String _createdAt = 'created_at';
  static const String _updatedAt = 'updated_at';

  static Database? _db;

  static Future<Database> _openDatabase() async {
    final databasesPath = await getDatabasesPath();
    String path = '$databasesPath/gits_inspector.db';

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $_table ($_id TEXT PRIMARY KEY, $_request TEXT, $_response TEXT, $_createdAt INTEGER, $_updatedAt INTEGER)');
    });
  }

  static Future<void> _validateDatabaseOpened() async {
    if (_db?.isOpen ?? false) return;
    _db = await _openDatabase();
  }

  static Future<void> insert(Inspector overviewInspector) async {
    await _validateDatabaseOpened();
    await _db?.insert(
      _table,
      overviewInspector.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateResponse(
      String uuid, ResponseInspector response) async {
    await _validateDatabaseOpened();
    await _db?.update(
      _table,
      {
        _response: response.toJson(),
        _updatedAt: DateTime.now().millisecondsSinceEpoch,
      },
      where: '$_id = ?',
      whereArgs: [uuid],
    );
  }

  static Future<List<Inspector>> getAll({int? limit, int? offset}) async {
    await _validateDatabaseOpened();
    final listMap = await _db?.query(
          _table,
          orderBy: '$_createdAt DESC',
          limit: limit,
          offset: offset,
        ) ??
        [];
    return listMap.map((e) => Inspector.fromMap(e)).toList();
  }

  static Future<Inspector?> get(String id) async {
    await _validateDatabaseOpened();
    final listMap =
        await _db?.query(_table, where: '$_id = ?', whereArgs: [id]) ?? [];
    if (listMap.isNotEmpty) return Inspector.fromMap(listMap.first);
    return null;
  }

  static Future<int?> delete(String id) async {
    await _validateDatabaseOpened();
    return await _db?.delete(_table, where: '$_id = ?', whereArgs: [id]);
  }

  static Future<void> deleteAll() async {
    await _validateDatabaseOpened();
    await _db?.delete(_table);
  }

  Future<void> close() async {
    if (_db?.isOpen ?? false) {
      await _db?.close();
    }
  }
}
