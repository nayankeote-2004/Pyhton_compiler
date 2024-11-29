import 'package:flutter/material.dart';
import 'package:python_compiler/screen/python_ui.dart';

void main() {
  runApp(PythonCodeExecutorApp());
}

class PythonCodeExecutorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Python Code Executor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PythonCodeExecutorScreen(),
    );
  }
}

//