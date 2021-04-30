import 'package:flutter/material.dart';

class SnapshotHandler extends StatelessWidget {
  final Widget errorWidget;
  final Widget waitingWidget;
  final Function dataFunction;
  final AsyncSnapshot<Object?> snapshot;

  const SnapshotHandler(
      {required this.errorWidget,
      required this.waitingWidget,
      required this.dataFunction,
      required this.snapshot});

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return waitingWidget;
    } else if (snapshot.hasError) {
      return errorWidget;
    } else if (snapshot.hasData) {
      return dataFunction(snapshot.data);
    } else {
      return Text("Ingen data");
    }
  }
}
