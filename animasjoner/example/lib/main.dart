import 'package:animations_example/pages/explicit/explicit_animations.dart';
import 'package:animations_example/pages/external/external_animations.dart';
import 'package:animations_example/pages/external/playback.dart';
import 'package:animations_example/pages/external/scroll_sync.dart';
import 'package:animations_example/pages/home.dart';
import 'package:animations_example/pages/implicit/container.dart';
import 'package:animations_example/pages/implicit/hero.dart';
import 'package:animations_example/pages/implicit/implicit_animations.dart';
import 'package:animations_example/pages/implicit/opacity.dart';
import 'package:animations_example/pages/implicit/switcher.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AnimatedExampleApp());
}

class AnimatedExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

        // External animations
        '/external/playback': (_) => ExternalSimpleControlsPage(),
        '/external/sync': (_) => ExternalScrollSyncPage(),

        // Implicit animations
        '/implicit/opacity': (_) => ImplicitOpacityPage(),
        '/implicit/container': (_) => ImplicitContainerPage(),
        '/implicit/switcher': (_) => ImplicitSwitcherPage(),
        '/implicit/hero': (_) => ImplicitHeroPage(),
      },
    );
  }
}
