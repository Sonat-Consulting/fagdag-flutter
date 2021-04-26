import 'package:flutter/material.dart';
import 'package:flutter_fagdag/data/cars_data.dart';
import 'package:flutter_fagdag/widgets/star_rating.dart';

class CarDetail extends StatefulWidget {
  final Car car;

  CarDetail({Key key, this.car}) : super(key: key);

  @override
  _CarDetailState createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  String message;

  @override
  void initState() {
    message = "";
    super.initState();
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      message = "";
    });
  }

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
                widget.car.photoUrl.toString(),
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
      Text(message,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
    ]);
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
            value: widget.car.rating.stars,
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
