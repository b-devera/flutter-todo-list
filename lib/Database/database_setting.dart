import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:todo_app/Database/ListData.dart';

class DatabaseSetting {
  DatabaseSetting._privateConstructor();
  static final DatabaseSetting instance = DatabaseSetting._privateConstructor();

  static late Database _db;

  String taskTable = 'task_table';
  String id = 'id';
  String name = 'name';
  String category = 'category';
  String date = 'date';
  String time = 'time';
  String checked = 'checked';

  Future<Database> get db async{
    _db = await _initDb();
    return _db;
  }

  Future<Database> _initDb() async{
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'taskit.db';
    print(path);
    final todoListDb =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $taskTable ($id INTEGER PRIMARY KEY AUTOINCREMENT,$name TEXT, $category TEXT, $date TEXT, $time TEXT,  $checked INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getMapTaskList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(taskTable);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getMapTaskList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    taskList.sort((taskA, taskB) => taskA.date!.compareTo(taskB.date!));
    return taskList;
  }

  Future<int> insertTask(Task task) async {
    Database db = await this.db;
    final int result = await db.insert(taskTable, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    Database db = await this.db;
    final int result = await db.update(taskTable, task.toMap(),
        where: '$id = ?', whereArgs: [task.id]);
    return result;
  }

  Future<int> deleteTask(int? lid) async {
    Database db = await this.db;
    final int result =
    await db.delete(taskTable, where: '$id = ?', whereArgs: [lid]);
    return result;
  }
}