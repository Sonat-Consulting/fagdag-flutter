import 'package:flutter/material.dart';
import 'package:flutter_fagdag/data/cars_data.dart';

class CarListItem extends StatelessWidget {
  final Car car;

  const CarListItem({required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: <Widget>[
          Hero(
            tag: 'carimage${car.model}',
            child: Image.network(
              car.photoUrl.toString(),
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 10,
            child: Text(
              car.brand,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
          ),
          Positioned(
            top: 70,
            left: 20,
            child: Text(
              car.model,
              style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
