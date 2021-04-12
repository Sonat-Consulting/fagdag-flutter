import 'package:animated_example/components/lottie_icon.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('animated'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: LottieIcon(LottieIcons.rotate_cw),
            trailing: LottieIcon(LottieIcons.arrow_right),
            title: Text('Implisitte animated'),
            subtitle: Text(
              'Enkle animated som kjøres ved endringer i state',
            ),
            onTap: () => Navigator.of(context).pushNamed('/implicit'),
          ),
          ListTile(
            leading: LottieIcon(LottieIcons.tool),
            trailing: LottieIcon(LottieIcons.arrow_right),
            title: Text('Eksplisitte animated'),
            subtitle: Text(
              'Kontrollerbare animated som kan trigges og modifiseres i kode',
            ),
            onTap: () => Navigator.of(context).pushNamed('/explicit'),
          ),
          ListTile(
            leading: LottieIcon(LottieIcons.cube),
            trailing: LottieIcon(LottieIcons.arrow_right),
            title: Text('Eksterne animated'),
            subtitle: Text(
              'Forhåndslaget vektorgrafikk og animated som lastes inn og rendres',
            ),
            onTap: () => Navigator.of(context).pushNamed('/external'),
          ),
          ListTile(
            leading: LottieIcon(LottieIcons.star),
            trailing: LottieIcon(LottieIcons.arrow_right),
            title: Text('Mine animated'),
            subtitle: Text(
              'animated du lager under fagdagen',
            ),
            onTap: () => Navigator.of(context).pushNamed('/my'),
          ),
        ],
      ),
    );
  }
}
