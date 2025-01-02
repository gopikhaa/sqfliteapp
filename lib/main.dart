import 'package:flutter/material.dart';
import 'package:my_sqflite_project/screens/notedetails.dart';
import 'package:my_sqflite_project/screens/notelists.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      title: 'Sqflite',
      home: NoteLists(),
    );
  }
}