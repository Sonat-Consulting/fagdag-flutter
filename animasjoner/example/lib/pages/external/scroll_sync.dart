import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ExternalScrollSyncPage extends StatefulWidget {
  @override
  _ExternalScrollSyncPageState createState() => _ExternalScrollSyncPageState();
}

class _ExternalScrollSyncPageState extends State<ExternalScrollSyncPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(
        () {
          animationController.value = scrollController.position.pixels;
          print(animationController.value);
        },
      );

    animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Lottie.asset(
          'assets/underwater.json',
          controller: animationController,
          fit: BoxFit.cover,
          onLoaded: (composition) {
            animationController
              ..duration = composition.duration
              ..forward();
          },
        ),
        SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 4,
          ),
        ),
      ],
    );
  }
}
