

import 'package:flutter/material.dart';
import 'package:todo_app/Account/login.dart';

ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color(0x2B72FFFF),
  primaryVariant: Color(0x2B72FFFF),
  secondary: Color(0xFF4169E1), //For button color
  secondaryVariant: Color(0xffffffff),
  surface: Color(0xff181818),
  background: Color(0xffffffff),
  error: Color(0xffff002d),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onBackground: Color(0xffffffff),
  onError: Color(0xff000000),
  brightness: Brightness.dark,
);



class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',

      home: LoginPage(title: 'login'),

    );
  }
}

void main() => runApp(const TodoApp());