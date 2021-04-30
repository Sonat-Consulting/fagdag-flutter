import 'package:flutter/material.dart';
import 'package:flutter_fagdag/screens/cars_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mine biler',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.white),
      home: SafeArea(
        child: Scaffold(
          body: CarsList(),
        ),
      ),
    );
  }
}
