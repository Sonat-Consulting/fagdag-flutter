import 'package:animated_example/pages/explicit/explicit_animations.dart';
import 'package:animated_example/pages/external/external_animations.dart';
import 'package:animated_example/pages/external/playback.dart';
import 'package:animated_example/pages/external/scroll_sync.dart';
import 'package:animated_example/pages/home.dart';
import 'package:animated_example/pages/implicit/implicit_animations.dart';
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
        // Main pages
        '/': (_) => HomePage(),
        '/explicit': (_) => ExplicitAnimationsPage(),
        '/external': (_) => ExternalAnimationsPage(),
        '/implicit': (_) => ImplicitAnimationsPage(),

        // Sub-pages
        '/external/playback': (_) => ExternalSimpleControlsPage(),
        '/external/sync': (_) => ExternalScrollSyncPage(),
      },
    );
  }
}
