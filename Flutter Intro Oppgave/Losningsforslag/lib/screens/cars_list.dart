import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fagdag/data/cars_data.dart';
import 'package:flutter_fagdag/widgets/car_detail.dart';
import 'package:flutter_fagdag/widgets/car_listitem.dart';

class CarsList extends StatefulWidget {
  @override
  _CarsListState createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  CarsDb _carsList = new CarsDb();
  Car _currentCar;
  Future carListFuture;

  handleCarCardTap(Car car) {
    setState(() {
      _currentCar = car;
    });
  }

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
              List<Car> cars = snapshot.data;
              return SizedBox(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return CarListItem(
                        car: cars[index], onTap: handleCarCardTap);
                  },
                ),
              );
            } else {
              return Text("Ingen data");
            }
          },
        ),
        _currentCar != null ? CarDetail(car: _currentCar) : Container()
      ],
    );
  }

  SizedBox buildProgressIndicator(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: Center(child: CircularProgressIndicator()));
  }
}
