///
/// Added by Atsuya
/// CMPE-137
/// 05/20/2022
///

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:todo_app/Database/ListData.dart';

class DatabaseSetting {
  DatabaseSetting._privateConstructor();
  static final DatabaseSetting instance = DatabaseSetting._privateConstructor();

  static late Database _db;

  String tasksTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colCategory = 'category';
  String colStatus = 'status';



  Future<Database> get db async {
    _db = await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'taskit.db';
    print(path);
    final todoListDb =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tasksTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT, $colDate TEXT, $colCategory TEXT, $colStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getMapTaskList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(tasksTable);
    return result;
  }
  //List only uncheck mark tasks
  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getMapTaskList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      if(Task.fromMap(taskMap).status == 0){
        taskList.add(Task.fromMap(taskMap));
      }
    });
    taskList.sort((taskA, taskB) => taskA.date!.compareTo(taskB.date!));
    return taskList;
  }

  //List only checked mark tasks
  Future<List<Task>> getCheckedTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getMapTaskList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      if(Task.fromMap(taskMap).status == 1){
        taskList.add(Task.fromMap(taskMap));
      }
    });
    taskList.sort((taskA, taskB) => taskA.date!.compareTo(taskB.date!));
    return taskList;
  }

  //List only category mark tasks
  Future<List<Task>> getCatOederTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getMapTaskList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    taskList.sort((taskA, taskB) => taskA.category!.compareTo(taskB.category!));
    return taskList;
  }

  // //Make school category list
  // Future<List<Task>> getSchoolCatTaskList() async {
  //   final List<Map<String, dynamic>> taskMapList = await getMapTaskList();
  //   final List<Task> schoolCatList = [];
  //   taskMapList.forEach((taskMap) {
  //     if(Task.fromMap(taskMap).category == 'School') {
  //       schoolCatList.add(Task.fromMap(taskMap));
  //     }
  //   });
  //   schoolCatList.sort((taskA, taskB) => taskA.date!.compareTo(taskB.date!));
  //   return schoolCatList;
  // }
  //
  // //Make work category list
  // Future<List<Task>> getWorkCatTaskList() async {
  //   final List<Map<String, dynamic>> taskMapList = await getMapTaskList();
  //   final List<Task> workCatList = [];
  //   taskMapList.forEach((taskMap) {
  //     if(Task.fromMap(taskMap).category == 'Work'){
  //       workCatList.add(Task.fromMap(taskMap));
  //     }
  //   });
  //   workCatList.sort((taskA, taskB) => taskA.date!.compareTo(taskB.date!));
  //   return workCatList;
  // }
  //
  // //Make daily category list
  // Future<List<Task>> getDailyCatTaskList() async {
  //   final List<Map<String, dynamic>> taskMapList = await getMapTaskList();
  //   final List<Task> dailyCatList = [];
  //   taskMapList.forEach((taskMap) {
  //     if(Task.fromMap(taskMap).category == 'Daily'){
  //       dailyCatList.add(Task.fromMap(taskMap));
  //     }
  //   });
  //   dailyCatList.sort((taskA, taskB) => taskA.date!.compareTo(taskB.date!));
  //   return dailyCatList;
  // }

  Future<int> insertTask(Task task) async {
    Database db = await this.db;
    final int result = await db.insert(tasksTable, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    Database db = await this.db;
    final int result = await db.update(tasksTable, task.toMap(),
        where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }

  Future<int> deleteTask(int? id) async {
    Database db = await this.db;
    final int result =
    await db.delete(tasksTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }
}