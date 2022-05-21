// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:todo_app/Profile/profile_page.dart';
// import 'package:todo_app/Database/ListData.dart';
// import 'package:todo_app/Database/database_setting.dart';
// import 'package:todo_app/RegisterList.dart';
// import 'package:todo_app/signin.dart';
//
//
//
//
// class TodoList extends StatefulWidget {
//   // const TodoList({Key? key, required this.title}) : super(key: key);
//   // final String title;
//
//   @override
//   _TodoListState createState() => _TodoListState();
// }
//
// class _TodoListState extends State<TodoList> {
//
//
//   Future<List<Task>>? _taskList;
//   final DateFormat _dateFormatter = DateFormat('MMM dd, YYYY');
//
//   @override
//   void initState() {
//     super.initState();
//     _updateTaskList();
//   }
//
//   _updateTaskList() {
//     setState(() {
//       _taskList = DatabaseSetting.instance.getTaskList();
//     });
//   }
//
//   // Display todo list contents
//   Widget _buildTask(Task task){
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 25),
//       child: Column(
//         children: [
//           ListTile(
//             title: Text(
//               task.name!,
//               style: TextStyle(
//                   fontFamily: 'ProximaNova',
//                   fontWeight: FontWeight.w800,
//                   fontSize: 18,
//                   decoration: task.checked == 0
//                       ? TextDecoration.none
//                       : TextDecoration.lineThrough),
//             ),
//             subtitle: Text(
//               '${_dateFormatter.format(task.date!)}',
//               style: TextStyle(
//                   fontFamily: 'ProximaNova',
//                   fontWeight: FontWeight.w800,
//                   fontSize: 15,
//                   decoration: task.checked == 0
//                       ? TextDecoration.none
//                       : TextDecoration.lineThrough),
//             ),
//             trailing: Checkbox(
//               onChanged: (value) {
//                 task.checked = value! ? 1 : 0;
//                 DatabaseSetting.instance.updateTask(task);
//                 _updateTaskList();
//               },
//               activeColor: Theme.of(context).primaryColor,
//               value: task.checked == 1 ? true : false,
//             ),
//             onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => RegisterList(
//                         updateTaskList: _updateTaskList, task: task))),
//           ),
//           Divider()
//         ],
//       ),
//     );
//   }
//
//   // main body
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         title:  Text('Todo List',
//             style: TextStyle(
//               fontFamily: 'ProximaNova',
//               fontWeight: FontWeight.w800,
//             )),
//       ),
//       body: FutureBuilder(
//           future: _taskList,
//           builder: (context, snapshot){
//             if (!snapshot.hasData){
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//
//             return ListView.builder(
//               padding: EdgeInsets.symmetric(vertical: 60.0),
//               itemCount: 1 + (snapshot.data as List<Task>).length,
//               itemBuilder: (BuildContext context, int index) {
//                 if (index == 0 || index == null) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 20.0, horizontal: 40.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'No tasks',
//                           style: TextStyle(
//                             fontFamily: 'ProximaNova',
//                             color: Colors.black,
//                             fontWeight: FontWeight.w800,
//                             fontSize: 30,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//                 return _buildTask((snapshot.data as List<Task>)[index - 1]);
//               },
//             );
//           }
//       ),
//
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         child: Container(
//             height: 75,
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 IconButton(
//                   iconSize: 30.0,
//                   padding: EdgeInsets.only(left: 28.0),
//                   icon: Icon(Icons.home),
//                   onPressed: (){
//                     setState(() {
//
//                     });
//                   },
//                 ),
//                 IconButton(
//                   iconSize: 30.0,
//                   padding: EdgeInsets.only(left: 28.0),
//                   icon: Icon(Icons.access_time_outlined),
//                   onPressed: (){
//                     setState(() {
//
//                     });
//                   },
//                 ),
//                 IconButton(
//                   iconSize: 30.0,
//                   padding: EdgeInsets.only(left: 28.0),
//                   icon: Icon(Icons.notifications_none),
//                   onPressed: (){
//                     setState(() {
//
//                     });
//                   },
//                 ),
//                 IconButton(
//                   iconSize: 30.0,
//                   padding: EdgeInsets.only(left: 28.0),
//                   icon: Icon(Icons.people),
//                   onPressed: ()=> {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ProfilePage(title: "profile"),
//                       ),
//                     )
//                   },
//                 ),
//               ],
//             )
//         ),
//         // onTap: _onItemTapped,
//         // currentIndex: _selectedIndex,
//       ),
//       floatingActionButton: Container(
//         height: 65.0,
//         width: 65.0,
//         child: FittedBox(
//           child: FloatingActionButton(
//             onPressed: () => {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => RegisterList(updateTaskList: _updateTaskList),
//                 ),
//               )
//             },
//             child: Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }