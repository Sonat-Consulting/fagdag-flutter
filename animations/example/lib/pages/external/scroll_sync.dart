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

  bool isAttached(ScrollController c) =>
      c.hasClients && c.position.hasContentDimensions;

  double get progress => isAttached(scrollController)
      ? scrollController.offset / scrollController.position.maxScrollExtent
      : 0;

  String get progressPercentage =>
      (progress.clamp(0, 1) * 100).toStringAsFixed(0) + '%';

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        animationController.value = progress;
      });

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
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: AnimatedBuilder(
              animation: animationController,
              builder: (context, _) =>
                  Text('Synk med scroll ($progressPercentage)'),
            ),
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              height: MediaQuery.of(context).size.height * 4,
            ),
          ),
        ),
      ],
    );
  }
}
