import 'package:flutter/material.dart';

class ExplicitTriggerTogglePage extends StatefulWidget {
  @override
  _ExplicitTriggerTogglePageState createState() =>
      _ExplicitTriggerTogglePageState();
}

class _ExplicitTriggerTogglePageState extends State<ExplicitTriggerTogglePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> containerSize;
  late Animation<Color?> containerColor;

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
                  color: containerColor.value,
                );
              },
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (_) {
                switch (controller.status) {
                  case AnimationStatus.completed:
                  case AnimationStatus.reverse:
                    controller.reverse();
                    break;
                  default:
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
