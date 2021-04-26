import 'package:animations_example/components/animated_list_tile.dart';
import 'package:flutter/material.dart';

class ExternalAnimationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eksterne animasjoner'),
      ),
      body: ListView(
        children: [
          AnimatedListTile(
            title: Text('Enkel avspilling'),
            subtitle: Text('underwater.json'),
            onTap: () => Navigator.of(context).pushNamed('/external/playback'),
          ),
          AnimatedListTile(
            title: Text('Synk med skroll'),
            subtitle: Text('underwater.json'),
            onTap: () => Navigator.of(context).pushNamed('/external/sync'),
          ),
        ],
      ),
    );
  }
}
