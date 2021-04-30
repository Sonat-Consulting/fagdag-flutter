import 'package:flutter/material.dart';

import 'package:observatory_solution/models/observation.dart';
import 'package:observatory_solution/state/image_state.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/observation.dart';
import '../state/observation_state.dart';

class ModifyObservationPage extends StatefulWidget {
  const ModifyObservationPage({Key? key}) : super(key: key);

  @override
  _ModifyObservationPageState createState() => _ModifyObservationPageState();
}

class _ModifyObservationPageState extends State<ModifyObservationPage> {
  final userIdController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedImageUrl;
  int? id;

  final idNode = FocusNode();
  final userIdNode = FocusNode();
  final titleNode = FocusNode();
  final descriptionNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  String? validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Can\'t be empty';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final observationToUpdate =
        ModalRoute.of(context)?.settings.arguments as Observation?;

    if (observationToUpdate != null) {
      id = observationToUpdate.id;
      userIdController.text = observationToUpdate.userId;
      titleController.text = observationToUpdate.title;
      descriptionController.text = observationToUpdate.description ?? '';
      selectedImageUrl = observationToUpdate.imageUrl;
    }

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
              SizedBox(height: 8.0),
              ImagePicker(
                selection: selectedImageUrl,
                onSelected: (url) {
                  setState(() {
                    selectedImageUrl = url;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send_rounded),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if (selectedImageUrl == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Select an image 📸'),
                ),
              );
            } else {
              final observation = Observation(
                id: id,
                description: descriptionController.text,
                userId: userIdController.text,
                title: titleController.text,
                imageUrl: selectedImageUrl!,
              );

              final state = Provider.of<ObservationState>(
                context,
                listen: false,
              );

              if (observationToUpdate != null && id != null) {
                state.update(id!, observation).then((value) {
                  Navigator.of(context).pop(value);
                });
              } else {
                state.create(observation).then((value) {
                  Navigator.of(context).pop(value);
                });
              }
            }
          }
        },
      ),
    );
  }
}

class ImagePicker extends StatelessWidget {
  final String? selection;
  final Function(String)? onSelected;

  const ImagePicker({Key? key, this.selection, this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageState>(
      builder: (context, state, child) {
        if (state.images != null) {
          return Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceAround,
            runSpacing: 8.0,
            children: state.images!.map((image) {
              final selected = selection != null && selection == image.url;

              return GestureDetector(
                onTap: () => onSelected?.call(image.url!),
                child: Container(
                  width: 128.0,
                  height: 128.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: selected ? 6.0 : 0,
                    ),
                  ),
                  child: Image.network(
                    image.url!,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          state.fetchImages(50);
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
