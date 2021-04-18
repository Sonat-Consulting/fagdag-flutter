import 'package:flutter/material.dart';

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
    final color = Colors.primaries[index];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => HeroTransitionPage(index: index),
        ));
      },
      child: Hero(
        tag: index,
        child: Material(
          color: color,
          child: Center(
            child: Text(
              'rgb(${color.red}, ${color.green}, ${color.blue})',
              style: TextStyle(
                color: color.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroTransitionPage extends StatelessWidget {
  final int index;

  const HeroTransitionPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.primaries[index];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: Hero(
              tag: index,
              child: Material(
                color: color,
                child: Center(
                  child: Text(
                    'rgb(${color.red}, ${color.green}, ${color.blue})',
                    style: TextStyle(
                      color: color.computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(100, (i) => i + 1).map((i) {
                return ListTile(
                  title: Text('Tile no. $i'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
