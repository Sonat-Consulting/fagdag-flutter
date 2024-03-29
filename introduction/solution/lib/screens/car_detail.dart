import 'package:flutter/material.dart';
import 'package:flutter_fagdag/data/cars_data.dart';
import 'package:flutter_fagdag/widgets/star_rating_widget.dart';

class CarDetail extends StatefulWidget {
  final Car car;

  CarDetail({required this.car});

  @override
  _CarDetailState createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  String message = "";

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
                  tag: 'carimage${widget.car.model}',
                  child: Image.network(
                    widget.car.photoUrl.toString(),
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
        buildTableRow('Merke', Text(widget.car.brand)),
        buildTableRow('Modell', Text(widget.car.model)),
        buildTableRow(
          'Årsmodell',
          Text(
            widget.car.year.toString(),
          ),
        ),
        buildTableRow(
          'Eiers rating',
          StarRatingWidget(
            value: widget.car.rating?.stars ?? 0,
            onRatingChanged: (newValue) {
              setState(() {
                message = "Du ønsker å gi denne bilen ratingen $newValue";
                widget.car.rating = new StarRating(newValue);
              });
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
