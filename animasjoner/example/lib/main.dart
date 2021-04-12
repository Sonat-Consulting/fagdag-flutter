import 'package:animated_example/pages/explicit_animations.dart';
import 'package:animated_example/pages/external_animations.dart';
import 'package:animated_example/pages/home.dart';
import 'package:animated_example/pages/implicit_animations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AnimatedExampleApp());
}

class AnimatedExampleApp extends StatelessWidget {
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
        '/explicit': (_) => ExplicitAnimationsPage(),
        '/external': (_) => ExternalAnimationsPage(),
        '/implicit': (_) => ImplicitAnimationsPage(),
      },
    );
  }
}
