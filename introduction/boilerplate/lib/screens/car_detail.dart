import 'package:flutter/material.dart';
import 'package:flutter_fagdag/data/cars_data.dart';
import 'package:flutter_fagdag/widgets/star_rating_widget.dart';

class CarDetail extends StatelessWidget {
  final Car car;

  String message = "";

  CarDetail({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          buildTable(),
          Card(
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
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
          Center(
            child: Text(message,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          ),
        ]),
      ),
    );
  }

  Table buildTable() {
    return Table(
      border: TableBorder.lerp(
          TableBorder(top: BorderSide(width: 2, color: Colors.red)),
          TableBorder(bottom: BorderSide(width: 4, color: Colors.green)),
          0.5),
      children: [
        buildTableRow('Merke', Text(car.brand)),
        buildTableRow('Modell', Text(car.model)),
        buildTableRow(
          'Årsmodell',
          Text(
            car.year.toString(),
          ),
        ),
        buildTableRow(
          'Eiers rating',
          StarRatingWidget(
            value: car.rating?.stars ?? 0,
            onRatingChanged: (newValue) {
              message = "Du ønsker å gi denne bilen ratingen $newValue";
              car.rating = new StarRating(newValue);
            },
          ),
        ),
        buildTableRow('', Text('(Trykk for å gi din rating)')),
      ],
    );
  }

  TableRow buildTableRow(String label, Widget value) {
    return TableRow(
      children: [
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        )),
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: value,
        ))
      ],
    );
  }
}
