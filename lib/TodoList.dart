import 'package:flutter/material.dart';
import 'package:todo_app/Profile/profile_page.dart';

class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.red,
      decoration: TextDecoration.lineThrough,
    );

  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: CircleAvatar(
        child: Text(todo.name[0]),
      ),
      title: Text(todo.name, style: _getTextStyle(todo.checked)),



          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(

                icon: Icon(
                  Icons.delete_outline,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
              onPressed: () {

                 // _onDeleteItemPressed(index);
              },
              ),
            ],
          ),
        );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int _selectedIndex = 0;

  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 3) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
          const ProfilePage(title: 'Register UI'),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: const Color(0xFF4169E1),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_outlined),
            label: '',
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4169E1),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF4169E1),
          onPressed: () => _displayDialog(),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Task'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Enter your task here'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }
}