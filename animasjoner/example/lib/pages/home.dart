import 'package:animated_example/components/animated_list_tile.dart';
import 'package:animated_example/components/lottie_icon.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animasjoner'),
      ),
      body: ListView(
        children: [
          AnimatedListTile(
            icon: LottieIcons.rotate_cw,
            title: Text('Implisitte animasjoner'),
            subtitle: Text(
              'Enkle animasjoner som kjøres automatisk ved endringer i state',
            ),
            onTap: () => Navigator.of(context).pushNamed('/implicit'),
          ),
          AnimatedListTile(
            icon: LottieIcons.tool,
            title: Text('Eksplisitte animasjoner'),
            subtitle: Text(
              'Kontrollerbare animasjoner som kan trigges og modifiseres i kode',
            ),
            onTap: () => Navigator.of(context).pushNamed('/explicit'),
          ),
          AnimatedListTile(
            icon: LottieIcons.cube,
            title: Text('Eksterne animasjoner'),
            subtitle: Text(
              'Forhåndslaget vektorgrafikk og animasjoner som lastes inn og rendres',
            ),
            onTap: () => Navigator.of(context).pushNamed('/external'),
          ),
        ],
      ),
    );
  }
}
