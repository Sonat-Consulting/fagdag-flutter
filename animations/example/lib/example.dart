import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..addListener(() {
        //print(controller.value);
      })
      ..addStatusListener((status) {
        print(status);
      })
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
