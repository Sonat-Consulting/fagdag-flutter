import 'package:animated/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AnimatedApp());
}

class AnimatedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animated',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
      },
    );
  }
}
