import 'dart:convert';

import 'package:http/http.dart';
import 'package:observatory_solution/models/nasa_image.dart';

class ImageRepository {
  static const _key = 'vdyw2rhLfbXhVJSpPrTsGm1bRHRLx90SIcLzgzQp';
  static const _baseUrl = 'api.nasa.gov';
  static const _path = '/planetary/apod';

  Uri _uri({Map<String, String>? query}) {
    (query ??= {})..addAll({'api_key': _key});

    return Uri.https(_baseUrl, _path, query);
  }

  Future<List<NasaImage>> fetchImages(int count) async {
    final uri = _uri(query: {'count': '$count'});
    final response = await get(uri);
    List<dynamic> array = jsonDecode(response.body);
    return array.map((i) => NasaImage.fromJson(i)).toList();
  }
}
