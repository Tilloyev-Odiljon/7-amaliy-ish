import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'task.dart';

class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper._instance();
  static Database? _db;

  DataBaseHelper._instance();
  String taskTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }
  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'todo_list.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $taskTable(
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT,
        $colDate TEXT,
        $colPriority TEXT,
        $colStatus INTEGER
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database? db = await this.db;
    if (db != null) {
      final List<Map<String, dynamic>> result = await db.query(taskTable);
      return result;
    }
    return [];
  }

  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    return taskList;
  }

  Future<int> insertTask(Task task) async {
    Database? db = await this.db;
    if (db != null) {
      return await db.insert(taskTable, task.toMap());
    }
    return 0;
  }
}