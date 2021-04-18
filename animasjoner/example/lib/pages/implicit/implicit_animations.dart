import 'package:animations_example/components/animated_list_tile.dart';
import 'package:flutter/material.dart';

class ImplicitAnimationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Implisitte animasjoner'),
      ),
      body: ListView(
        children: [
          AnimatedListTile(
            title: Text('Synlighet'),
            subtitle: Text('AnimatedOpacity'),
            onTap: () => Navigator.of(context).pushNamed('/implicit/opacity'),
          ),
          AnimatedListTile(
            title: Text('Containere'),
            subtitle: Text('AnimatedContainer'),
            onTap: () => Navigator.of(context).pushNamed('/implicit/container'),
          ),
          AnimatedListTile(
            title: Text('Bytting av widgets'),
            subtitle: Text('AnimatedSwitcher'),
            onTap: () => Navigator.of(context).pushNamed('/implicit/switcher'),
          ),
          AnimatedListTile(
            title: Text('Hero-animasjoner'),
            subtitle: Text('Hero'),
            onTap: () => Navigator.of(context).pushNamed('/implicit/hero'),
          ),
        ],
      ),
    );
  }
}
