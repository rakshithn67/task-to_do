// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../models/task_model.dart';
//
// class DbHelpers {
//   Future<Database> dataBase() async {
//     return openDatabase(
//       join(
//         await getDatabasesPath(),
//         'taskTodo.db',
//       ),
//       onCreate: (db, version) async {
//         return await db.execute(
//             'CREATE TABLE Task (id INTEGER PRIMARY KEY, title  TEXT, description  TEXT)');
//       },
//       version: 1,
//     );
//   }
//
//   Future insertTask(Task task) async {
//     final db = await dataBase();
//     return db.insert('Task', task.toMap());
//   }
//
//   Future<List<Task>> getTask() async {
//     final db = await dataBase();
//     List<Map<String, dynamic>> taskData = await db.query('Task');
//
//     return taskData.map(
//       (e) {
//         return Task(
//           title: e['title'],
//           description: e['description'],
//         );
//       },
//     ).toList();
//   }
// }

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'users.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE users(id TEXT PRIMARY KEY, title TEXT, description TEXT)');
        }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> deleteData(String table, String id) async {
    final db = await DBHelper.database();

    db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> updateData(
      String table, String id, Map<String, Object> data) async {
    final db = await DBHelper.database();

    db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }
}
