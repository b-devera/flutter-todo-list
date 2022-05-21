import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/Database/ListData.dart';
import 'package:todo_app/Database/database_setting.dart';
import 'package:todo_app/Profile/profile_page.dart';

import 'package:todo_app/Profile/user_data.dart';
import 'package:todo_app/TodoList.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class RegisterList extends StatefulWidget {
  final Function? updateTaskList;
  final Task? task;

  RegisterList({this.updateTaskList, this.task});

  @override
  _RegisterListState createState() => _RegisterListState();
}

class _RegisterListState extends State<RegisterList> {
  int _selectedIndex = 0;

  final _formKey = GlobalKey<FormState>();
  String? _name = "";
  String? _category = "";
  DateTime? _date = DateTime.now();
  TimeOfDay? _time = TimeOfDay.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final TimeOfDayFormat _timeFormatter = TimeOfDayFormat.HH_colon_mm;

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _date!,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  _handleTimePicker() async {
    final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: _time!,
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                // Using 24-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget!);
        });
    if (time != null && time != _time) {
      setState(() {
        _time = time;
      });
      _timeController.text = _dateFormatter.format(time);
    }
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('$_name, $_category, $_date, $_time');

      // Insert Task to Users Database
      Task task = Task(name: _name, category: _category, date: _date, time: _time);
      if (widget.task == null) {
        task.checked = 0;
        DatabaseSetting.instance.insertTask(task);
      } else {
        // Update Task to Users Database
        task.id = widget.task!.id;
        task.checked = widget.task!.checked;
        DatabaseSetting.instance.updateTask(task);
      }

      widget.updateTaskList!();
      Navigator.pop(context);
    }
  }

  _delete() {
    DatabaseSetting.instance.deleteTask(widget.task!.id);
    widget.updateTaskList!();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = _dateFormatter.format(_date!);
    _timeController.text = _timeFormatter.format(_time!);

    if (widget.task != null) {
      _name = widget.task!.name;
      _category = widget.task!.category;
      _date = widget.task!.date;
      _time = widget.task!.time;
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                widget.task == null ? 'Add Task' : 'Update Task',
                style: TextStyle(
                    fontFamily: 'ProximaNova',
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 40.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Form(
                key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              labelText: 'Event name',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: 'ProximaNova',
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please Enter a Task Title'
                              : null,
                          onSaved: (input) => _name = input,
                          initialValue: _name,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Category',
                            labelStyle: TextStyle(
                              fontFamily: 'ProximaNova',
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please Enter a Task Title'
                              : null,
                          onSaved: (input) => _category = input,
                          initialValue: _category,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          style: TextStyle(fontSize: 18),
                          onTap: _handleDatePicker,
                          decoration: InputDecoration(
                              labelText: 'Date',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: 'ProximaNova',
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          readOnly: true,
                          controller: _timeController,
                          style: TextStyle(fontSize: 18),
                          onTap: _handleTimePicker,
                          decoration: InputDecoration(
                              labelText: 'Date',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: 'ProximaNova',
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: TextButton(
                          onPressed: _submit,
                          child: Text(
                            widget.task == null ? 'Add' : 'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      widget.task != null
                      ? Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: TextButton(
                          onPressed: _delete,
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'ProximaNova',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      )
                      :SizedBox.shrink(),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
