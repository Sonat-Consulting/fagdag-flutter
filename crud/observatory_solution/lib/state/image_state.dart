import 'package:flutter/material.dart';
import 'package:observatory_solution/models/nasa_image.dart';
import 'package:observatory_solution/repositories/image_repository.dart';

class ImageState extends ChangeNotifier {
  final ImageRepository _repository;

  List<NasaImage>? _images;
  List<NasaImage>? get images => _images
      ?.where((i) => i.url != null && !i.url!.contains('youtube'))
      .toList();

  ImageState() : this._repository = ImageRepository();

  Future<List<NasaImage>?> fetchImages(int count) async {
    _repository.fetchImages(count).then((res) {
      _images = res;
      notifyListeners();
      return res;
    });
  }
}
