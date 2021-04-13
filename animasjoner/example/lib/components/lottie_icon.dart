import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieIcons {
  static const cube = 'assets/cube.json';
  static const rotate_cw = 'assets/rotate_cw.json';
  static const star = 'assets/star.json';
  static const tool = 'assets/tool.json';
  static const arrow_right = 'assets/arrow_right.json';
}

class LottieIcon extends StatefulWidget {
  final String assetPath;
  final bool? animate;

  const LottieIcon(this.assetPath, {this.animate, Key? key}) : super(key: key);

  @override
  _LottieIconState createState() => _LottieIconState();
}

class _LottieIconState extends State<LottieIcon> with TickerProviderStateMixin {
  late AnimationController controller;
  final duration = Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);
    if (widget.animate ?? false) {
      controller.forward();
    }
  }

  @override
  void didUpdateWidget(LottieIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animate == false) {
      controller.reset();
    } else {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24.0,
      height: 24.0,
      child: Lottie.asset(widget.assetPath, controller: controller),
    );
  }
}
