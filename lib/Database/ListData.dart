
import 'package:flutter/material.dart';

class Task {
  int? id;
  String? name;
  String? category;
  DateTime? date;
  TimeOfDay? time;
  int? checked;

  Task({this.name, this.category, this.date, this.time, this.checked});
  Task.withId({this.id, this.name, this.category, this.date, this.time, this.checked});

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['category'] = category;
    map['date'] = date!.toIso8601String();
    map['time'] = time!;
    map['checked'] = checked;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map){
    return Task.withId(
        id: map['id'],
        name: map['name'],
        category: map['category'],
        date: map['date'],
        time: map['time'],
        checked: map['checked']);
  }
}

// void ListData() async{
//   final database = openDatabase(join(await getDatabasesPath(), 'todo_database.db'),
//     onCreate: (db, version) {
//       return db.execute(
//         "Create table todo list",
//       );
//     },
//     version: 1,
//   );
//
//   Future<void> insertTodo(TodoDatabase todo) async {
//     final Database db = await database;
//     await db.insert(
//       'todo',
//       todo.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<List>getTodos() async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('todo');
//     return List.generate(maps.length, (i) {
//       return TodoDatabase(
//         name: maps[i]['name'],
//         category: maps[i]['category'],
//         date: maps[i]['date'],
//         time: maps[i]['time'],
//         checked: maps[i]['checked'],
//       );
//     });
//   }
//
//   // Future<void> updateTodos(TodoDatabase todo) async {
//   //   // Get a reference to the database.
//   //   final db = await database;
//   //   await db.update(
//   //     'todo',
//   //     todo.toMap(),
//   //     where: "name = ?",
//   //     whereArgs: [todo.name],
//   //     conflictAlgorithm: ConflictAlgorithm.fail,
//   //   );
//   // }
//
//   Future<void> deleteTodo(String name) async {
//     final db = await database;
//     await db.delete(
//       'todo',
//       where: "name = ?",
//       whereArgs: [name],
//     );
//   }
// }



