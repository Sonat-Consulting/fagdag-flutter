import 'package:animated/components/lottie_icon.dart';
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
          ListTile(
            leading: LottieIcon(LottieIcons.rotate_cw),
            trailing: LottieIcon(LottieIcons.arrow_right),
            title: Text('Implisitte animasjoner'),
            subtitle: Text(
              'Enkle animasjoner som kjøres ved endringer i state',
            ),
            onTap: () => Navigator.of(context).pushNamed('/implicit'),
          ),
          ListTile(
            leading: LottieIcon(LottieIcons.tool),
            trailing: LottieIcon(LottieIcons.arrow_right),
            title: Text('Eksplisitte animasjoner'),
            subtitle: Text(
              'Kontrollerbare animasjoner som kan trigges og modifiseres i kode',
            ),
            onTap: () => Navigator.of(context).pushNamed('/explicit'),
          ),
          ListTile(
            leading: LottieIcon(LottieIcons.cube),
            trailing: LottieIcon(LottieIcons.arrow_right),
            title: Text('Eksterne animasjoner'),
            subtitle: Text(
              'Forhåndslaget vektorgrafikk og animasjoner som lastes inn og rendres',
            ),
            onTap: () => Navigator.of(context).pushNamed('/external'),
          ),
          ListTile(
            leading: LottieIcon(LottieIcons.star),
            trailing: LottieIcon(LottieIcons.arrow_right),
            title: Text('Mine animasjoner'),
            subtitle: Text(
              'Animasjoner du lager under fagdagen',
            ),
            onTap: () => Navigator.of(context).pushNamed('/my'),
          ),
        ],
      ),
    );
  }
}
