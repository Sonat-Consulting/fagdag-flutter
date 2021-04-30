import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fagdag/data/cars_data.dart';
import 'package:flutter_fagdag/screens/car_detail.dart';
import 'package:flutter_fagdag/widgets/car_listitem.dart';

class CarsList extends StatefulWidget {
  @override
  _CarsListState createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  CarsDb _carsList = new CarsDb();

  late Future carListFuture;

  @override
  initState() {
    super.initState();
    carListFuture = _carsList.getCarsList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: carListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildProgressIndicator(context);
            } else if (snapshot.hasData) {
              var cars = snapshot.data as List<Car>;
              return SizedBox(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CarDetail(car: cars[index])));
                      },
                      child: CarListItem(car: cars[index]),
                    );
                  },
                ),
              );
            } else {
              return Text("Ingen data");
            }
          },
        ),
      ],
    );
  }

  SizedBox buildProgressIndicator(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: Center(child: CircularProgressIndicator()));
  }
}
