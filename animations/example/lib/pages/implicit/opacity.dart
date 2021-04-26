import 'package:animations_example/shared.dart';
import 'package:flutter/material.dart';

class ImplicitOpacityPage extends StatefulWidget {
  @override
  _ImplicitOpacityPageState createState() => _ImplicitOpacityPageState();
}

class _ImplicitOpacityPageState extends State<ImplicitOpacityPage> {
  bool toggled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Synlighet'),
        actions: [
          IconButton(
            icon: Icon(
              toggled ? Icons.toggle_on_rounded : Icons.toggle_off_rounded,
            ),
            onPressed: () => setState(() => toggled = !toggled),
          ),
        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          duration: defaultDuration,
          opacity: toggled ? 1 : 0,
          child: FlutterLogo(
            size: 200,
            style: FlutterLogoStyle.horizontal,
          ),
        ),
      ),
    );
  }
}
