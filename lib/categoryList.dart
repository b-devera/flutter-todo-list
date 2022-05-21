import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:todo_app/Profile/profile_page.dart';
import 'package:todo_app/Database/ListData.dart';
import 'package:todo_app/Database/database_setting.dart';
import 'package:todo_app/RegisterList.dart';
import 'package:todo_app/TodoList.dart';
import 'package:todo_app/checkedList.dart';




class categoryList extends StatefulWidget {
  // const TodoList({Key? key, required this.title}) : super(key: key);
  // final String title;

  @override
  _categoryList createState() => _categoryList();
}

class _categoryList extends State<categoryList> {
  Future<List<Task>>? _taskList;

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');



  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState(() {
      _taskList = DatabaseSetting.instance.getCheckedTaskList();
    });
  }


  Widget _buildTask(Task task) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(

        children: [
          ListTile(
            title: Text(
              task.title!,
              style: TextStyle(
                  fontFamily: 'ProximaNova',
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  decoration: task.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough),
            ),
            subtitle: Text(
              '${_dateFormatter.format(task.date!)} * ${task.category}',
              style: TextStyle(
                  fontFamily: 'ProximaNova',
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  decoration: task.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough),
            ),
            trailing: Checkbox(
              onChanged: (value) {
                task.status = value! ? 1 : 0;
                DatabaseSetting.instance.updateTask(task);
                _updateTaskList();
              },
              activeColor: Theme.of(context).primaryColor,
              value: task.status == 1 ? true : false,
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category',
            style: TextStyle(
              fontFamily: 'ProximaNova',
              fontWeight: FontWeight.w800,
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
            height: 75,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(Icons.home),
                  onPressed: ()=> {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TodoList(),
                      ),
                    )
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(Icons.all_inbox),
                  onPressed: ()=> {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => categoryList(),
                      ),
                    )
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(Icons.access_time_outlined),
                  onPressed: ()=> {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => checkedList(),
                      ),
                    )
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(Icons.people),
                  onPressed: ()=> {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfilePage(title: "profile"),
                      ),
                    )
                  },
                ),
              ],
            )
        ),
        // onTap: _onItemTapped,
        // currentIndex: _selectedIndex,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RegisterList(updateTaskList: _updateTaskList),
            ),
          )
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _taskList,
        builder: (context, snapshot) {
          // if (!snapshot.hasData) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          final int? completedTaskCount = (snapshot.data as List<Task>)
              .where((Task task) => task.status == 1)
              .toList()
              .length;

          return ListView.builder(
            itemCount: 1 + (snapshot.data as List<Task>).length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    child: new Text ('Daily', style: new TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                    ),),
                    decoration: new BoxDecoration(
                        color: Colors.teal[900]
                    ),
                    alignment: Alignment(0,-1),
                    Text (_dailyTaskList),
                  ),

                  new Container(
                    child: new Text ('School', style: new TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                    ),),
                    decoration: new BoxDecoration(
                        color: Colors.teal[600]
                    ),
                    alignment: Alignment(0,-1),
                  ),
                  new Container(
                    child: new Text ('Work', style: new TextStyle(
                        color: Colors.black54,
                        fontSize: 30,
                    ),),
                    decoration: new BoxDecoration(
                        color: Colors.teal[200]
                    ),
                    alignment: Alignment(0,-1),
                  ),
                ],
              );
              // return _buildTask((snapshot.data as List<Task>)[index - 1]);
              // return Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: <Widget>[
              //     new Container(
              //       child: new Text ('Daily', style: new TextStyle(
              //         color: Colors.white
              //       ),),
              //       decoration: new BoxDecoration(
              //         color: Colors.teal[900]
              //       ),
              //       alignment: Alignment(0,-1),
              //     ),
              //     new Container(
              //       child: new Text ('School', style: new TextStyle(
              //           color: Colors.white
              //       ),),
              //       decoration: new BoxDecoration(
              //           color: Colors.teal[600]
              //       ),
              //       alignment: Alignment(0,-1),
              //     ),
              //     new Container(
              //       child: new Text ('Work', style: new TextStyle(
              //           color: Colors.black54
              //       ),),
              //       decoration: new BoxDecoration(
              //           color: Colors.teal[200]
              //       ),
              //       alignment: Alignment(0,-1),
              //     ),
              //   ],
              // );
            },
          );
        },
      ),
    );
  }

}