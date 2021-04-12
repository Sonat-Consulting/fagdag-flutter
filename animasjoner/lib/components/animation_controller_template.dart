import 'package:flutter/material.dart';

class AnimationControllerTemplate extends StatefulWidget {
  @override
  _AnimationControllerTemplateState createState() =>
      _AnimationControllerTemplateState();
}

class _AnimationControllerTemplateState
    extends State<AnimationControllerTemplate> with TickerProviderStateMixin {
  late AnimationController controller;
  final duration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration)..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: Container(
        color: Colors.green,
        width: 200.0,
        height: 200.0,
        child: Center(
          child: Text('Whee!'),
        ),
      ),
      builder: (context, child) {
        return Transform.rotate(
          angle: controller.value * 2.0 * 3.14,
          child: child,
        );
      },
    );
  }
}
