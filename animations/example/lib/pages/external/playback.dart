import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ExternalSimpleControlsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Lottie.asset(
          'assets/underwater.json',
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Enkel avspilling'),
          ),
        ),
      ],
    );
  }
}
