import 'package:flutter/material.dart';

import 'package:observatory/models/observation.dart';
import 'package:observatory/state/observation_state.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddObservationPage extends StatefulWidget {
  final Function(Observation)? onObservationCreated;

  const AddObservationPage({Key? key, this.onObservationCreated})
      : super(key: key);

  @override
  _AddObservationPageState createState() => _AddObservationPageState();
}

class _AddObservationPageState extends State<AddObservationPage> {
  final idController = TextEditingController();
  final userIdController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final idNode = FocusNode();
  final userIdNode = FocusNode();
  final titleNode = FocusNode();
  final descriptionNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Can\'t be empty';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              TextFormField(
                controller: userIdController,
                validator: validator,
                focusNode: userIdNode,
                onFieldSubmitted: (_) => userIdNode.requestFocus(),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'UserID',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.sync_rounded),
                    onPressed: () {
                      setState(() {
                        userIdController.text = Uuid().v4();
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                focusNode: titleNode,
                validator: validator,
                controller: titleController,
                onFieldSubmitted: (_) => descriptionNode.requestFocus(),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                focusNode: descriptionNode,
                controller: descriptionController,
                validator: validator,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send_rounded),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            final observation = Observation(
              userId: userIdController.text,
              title: titleController.text,
              description: descriptionController.text,
            );

            Provider.of<ObservationState>(context, listen: false)
                .create(observation)
                .then((_) {
              widget.onObservationCreated?.call(observation);
              Navigator.pop(context);
            });
          }
        },
      ),
    );
  }
}
