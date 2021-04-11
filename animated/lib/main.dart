import 'package:animated/pages/explicit_animations.dart';
import 'package:animated/pages/external_animations.dart';
import 'package:animated/pages/home.dart';
import 'package:animated/pages/implicit_animations.dart';
import 'package:animated/pages/my_animations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/explicit': (_) => ExplicitAnimationsPage(),
        '/external': (_) => ExternalAnimationsPage(),
        '/implicit': (_) => ImplicitAnimationsPage(),
        '/my': (_) => MyAnimationsPage(),
      },
    );
  }
}
