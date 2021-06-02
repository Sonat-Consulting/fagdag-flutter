import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final Object? error;
  MyErrorWidget({this.error});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/sadbart.png",
                fit: BoxFit.fill,
              ),
              Center(child: Text(error.toString())),
            ],
          ))
    ]);
  }
}
