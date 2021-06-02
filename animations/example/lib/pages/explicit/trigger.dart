import 'package:flutter/material.dart';

class ExplicitTriggerTogglePage extends StatefulWidget {
  @override
  _ExplicitTriggerTogglePageState createState() =>
      _ExplicitTriggerTogglePageState();
}

class _ExplicitTriggerTogglePageState extends State<ExplicitTriggerTogglePage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> containerSize;
  late Animation<Color?> containerColor;
  late Animation<double> containerRadius;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    containerSize = Tween(
      begin: 200.0,
      end: 300.0,
    ).animate(controller);

    containerColor = ColorTween(
      begin: Colors.green,
      end: Colors.blue,
    ).animate(controller);

    containerRadius = Tween(
      begin: 0.0,
      end: 100.0,
    ).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trigger'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                return Container(
                  width: containerSize.value,
                  height: containerSize.value,
                  decoration: BoxDecoration(
                    color: containerColor.value,
                    borderRadius: BorderRadius.circular(containerRadius.value),
                  ),
                );
              },
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (_) {
                switch (controller.status) {
                  case AnimationStatus.completed:
                  case AnimationStatus.reverse:
                    controller.duration = Duration(seconds: 1);
                    controller.reverse();
                    break;
                  default:
                    controller.duration = Duration(seconds: 5);
                    controller.forward();
                }
              },
              onTapUp: (_) => controller.stop(),
              onTapCancel: () => controller.stop(),
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Press & hold',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
