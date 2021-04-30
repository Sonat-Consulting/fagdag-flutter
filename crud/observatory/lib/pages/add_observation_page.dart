import 'package:flutter/material.dart';
import 'package:observatory/models/nasa_image.dart';

import 'package:observatory/models/observation.dart';
import 'package:observatory/state/image_state.dart';
import 'package:observatory/state/observation_state.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddObservationPage extends StatefulWidget {
  const AddObservationPage({Key? key}) : super(key: key);

  @override
  _AddObservationPageState createState() => _AddObservationPageState();
}

class _AddObservationPageState extends State<AddObservationPage> {
  final idController = TextEditingController();
  final userIdController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  NasaImage? selectedImage;

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
                selection: selectedImage,
                onSelected: (image) {
                  setState(() {
                    selectedImage = image;
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
            if (selectedImage == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Select an image 📸'),
              ));
            } else {
              final observation = Observation(
                userId: userIdController.text,
                title: titleController.text,
                description: descriptionController.text,
                imageUrl: selectedImage!.url,
              );

              Provider.of<ObservationState>(context, listen: false)
                  .create(observation)
                  .then((res) {
                Navigator.pop(context, res);
              });
            }
          }
        },
      ),
    );
  }
}

class ImagePicker extends StatelessWidget {
  final NasaImage? selection;
  final Function(NasaImage)? onSelected;

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
              final selected = selection != null && selection == image;

              return GestureDetector(
                onTap: () => onSelected?.call(image),
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
                    image.url,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          state.fetchImages(25);
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
