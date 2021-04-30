import 'package:animations_example/components/animated_list_tile.dart';
import 'package:flutter/material.dart';

class ExplicitAnimationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eksplisitte animasjoner'),
      ),
      body: ListView(
        children: [
          AnimatedListTile(
            title: Text('Trigger'),
            subtitle: Text('AnimationController'),
            onTap: () => Navigator.of(context).pushNamed('/explicit/trigger'),
          ),
        ],
      ),
    );
  }
}
