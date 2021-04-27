import 'package:flutter/material.dart';
import 'package:flutter_fagdag/data/cars_data.dart';
import 'package:flutter_fagdag/widgets/car_detail.dart';

class CarListItem extends StatelessWidget {
  final Car car;
  final Function onTap;

  const CarListItem({Key key, this.car, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => CarDetail(car: car)));
      },
      child: Card(
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
      ),
    );
  }
}
