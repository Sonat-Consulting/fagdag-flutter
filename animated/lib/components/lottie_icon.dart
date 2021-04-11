import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieIcons {
  static const cube = 'assets/cube.json';
  static const rotate_cw = 'assets/rotate_cw.json';
  static const star = 'assets/star.json';
  static const tool = 'assets/tool.json';
  static const arrow_right = 'assets/arrow_right.json';
}

class LottieIcon extends StatelessWidget {
  final String assetPath;

  const LottieIcon(this.assetPath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24.0,
      height: 24.0,
      child: Lottie.asset(assetPath),
    );
  }
}
