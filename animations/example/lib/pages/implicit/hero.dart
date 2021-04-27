import 'package:flutter/material.dart';

class ColoredHero extends StatelessWidget {
  final int index;

  const ColoredHero({Key? key, required this.index}) : super(key: key);

  Color get color => Colors.primaries[index];

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index,
      child: Material(
        color: color,
        child: Center(
          child: Text(
            'rgb(${color.red}, ${color.green}, ${color.blue})',
            style: TextStyle(
              color:
                  color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ImplicitHeroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero-animasjoner'),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.0,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        children: List.generate(
          Colors.primaries.length,
          (i) => buildContainer(context, i),
        ).toList(),
      ),
    );
  }

  Widget buildContainer(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => HeroTransitionPage(index: index),
        ));
      },
      child: ColoredHero(index: index),
    );
  }
}

class HeroTransitionPage extends StatelessWidget {
  final int index;

  const HeroTransitionPage({Key? key, required this.index}) : super(key: key);

  List<Widget> get generatedChildren {
    return List.generate(100, (i) => i + 1).map((i) {
      return ListTile(
        title: Text('Tile no. $i'),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: ColoredHero(index: index),
          ),
          SliverList(
            delegate: SliverChildListDelegate(generatedChildren),
          ),
        ],
      ),
    );
  }
}
