import 'dart:async';
import 'dart:convert';

import 'package:crud_assignment/observations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Observations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ObservationPage(title: 'Observations'),
    );
  }
}

class ObservationPage extends StatefulWidget {
  ObservationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ObservationPageState createState() => _ObservationPageState();
}

class _ObservationPageState extends State<ObservationPage> {
  final _formKey = GlobalKey<FormState>();

  final userId = "c3fe54f7-9aeb-4719-9bd9-9b6bdd3efc62";

  TextEditingController titleController = TextEditingController(text:"Title");
  TextEditingController descriptionController = TextEditingController(text:"...");

  late Future<List<Observation>> _observations;

  @override
  void initState() {
    super.initState();
    _observations = listObservations();
  }

  Widget buildList(List<Observation> observations) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: observations.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListLine(
                      observation:observations[index],
                      onDelete: (toDelete) {
                        setState(() {
                          _observations = deleteObservation(toDelete.id!)
                              .then((value) => observations.where((element) => element.id != toDelete.id).toList()
                          );
                        });
                      },
                      onUpdate: (toUpdate) {
                        // TODO implement in Assignment 1
                      }
                  );
                })),
        Form(
            key:_formKey,
            child: Column(children: <Widget>[
              TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add a title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Enter observation title'),
              ),
              TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Enter observation description'),
                  ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newObservation = Observation(userId:userId,title:titleController.text,description:descriptionController.text);
                    setState(() {
                      _observations = createObservation(newObservation)
                        .then((value) => observations + [value] );
                    });
                  }
                },
                child: Text('Create Observation'),
              ),
            ]))
      ],
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<Observation>>(
            future: _observations,
            builder: (context, snapshot)
    {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          return buildList(snapshot.data!);
        }
        else if (snapshot.hasError) {
          // TODO implement in Assignment 2
          return Text("${snapshot.error}");
        }
      }
      return CircularProgressIndicator();
    })
      ),
    );
  }
}




class ListLine extends StatefulWidget {
  ListLine({Key? key, required this.observation, required this.onDelete,required this.onUpdate}) : super(key: key);

  final Observation observation;
  final Function(Observation) onDelete;
  final Function(Observation) onUpdate;

  @override
  _ListLineState createState() => _ListLineState();

}


class _ListLineState extends State<ListLine> {

  bool edit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(2),
      color: Colors.blue[400],
      child: Row(
          children: edit ?  getEditable() : getNonEditable(),
      )
    );
  }


  List<Widget> getNonEditable() {
    return [Image(image: AssetImage('images/globular.png')),
    Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '${widget.observation.title}',
              style: TextStyle(fontSize: 18),
            ))
    ),
    Expanded(child:
    Text(
      '${widget.observation.description}',
      style: TextStyle(fontSize: 12),
    )
    ),
    Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(children: <Widget>[
          ElevatedButton(
              child: Text('Edit'),
              onPressed: () {
                setState(() {
                  edit = true;
                });
              }
          ),
          ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                widget.onDelete(widget.observation);
              }
          )
        ]
        )
    )
    ];
  }


  List<Widget> getEditable() {
    return [Image(image: AssetImage('images/globular.png')),
    Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '${widget.observation.title}',
              style: TextStyle(fontSize: 18),
            ))
    ),
    Expanded(child:
    Text(
      '${widget.observation.description}',
      style: TextStyle(fontSize: 12),
    )
    ),
    Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(children: <Widget>[
          ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                widget.onUpdate(widget.observation);
                setState(() {
                  edit = false;
                });
              }
          ),
          ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                setState(() {
                  edit = false;
                });
              }
          ),
          ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                widget.onDelete(widget.observation);
              }
          )
        ]
        )
    )
    ];
  }

}