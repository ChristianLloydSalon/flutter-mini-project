import 'package:flutter/material.dart';
import 'package:mini_project/modules/screens/blog/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Norse Mythology',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Quicksand'
      ),
      home: const HomeScreen(),
    );
  }
}
