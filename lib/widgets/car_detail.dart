import 'package:flutter/material.dart';
import 'package:flutter_fagdag/data/cars_data.dart';
import 'package:flutter_fagdag/widgets/star_rating.dart';

class CarDetail extends StatelessWidget {
  final Car car;

  const CarDetail({Key key, this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildTable(),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: <Widget>[
              Image.network(
                car.photoUrl.toString(),
                fit: BoxFit.fill,
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
      ),
    ]);
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
              'Rating',
              StarRatingWidget(
                value: car.rating.stars,
                filledStar:
                    Icon(Icons.star_border_outlined, color: Colors.yellow[800]),
                unfilledStar:
                    Icon(Icons.star_border_outlined, color: Colors.grey),
              )),
        ]);
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
