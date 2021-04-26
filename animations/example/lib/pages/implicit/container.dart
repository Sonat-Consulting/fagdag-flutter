import 'package:animations_example/shared.dart';
import 'package:flutter/material.dart';

class ImplicitContainerPage extends StatefulWidget {
  @override
  _ImplicitContainerPageState createState() => _ImplicitContainerPageState();
}

class _ImplicitContainerPageState extends State<ImplicitContainerPage> {
  bool toggled = false;

  BoxDecoration get toggledDecoration {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red, Colors.blue],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(50.0),
      border: Border.all(
        color: Colors.pink,
        width: 5.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 24.0,
          spreadRadius: 10.0,
        ),
      ],
    );
  }

  BoxDecoration get untoggledDecoration {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple, Colors.yellow],
      ),
      borderRadius: BorderRadius.circular(6.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Containere'),
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
        child: AnimatedContainer(
          duration: defaultDuration,
          width: 200,
          height: 200,
          decoration: toggled ? toggledDecoration : untoggledDecoration,
        ),
      ),
    );
  }
}
