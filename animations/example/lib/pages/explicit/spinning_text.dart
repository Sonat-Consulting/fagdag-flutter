import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpinningText extends StatefulWidget {
  @override
  _SpinningTextState createState() => _SpinningTextState();
}

class _SpinningTextState extends State<SpinningText>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spinnende tekst'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Switch.adaptive(value: true, onChanged: (_) {});
          },
        ),
      ),
    );
  }
}
