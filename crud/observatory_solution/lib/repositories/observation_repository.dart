import 'dart:io';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:observatory_solution/models/observation.dart';

class ObservationRepository {
  static const _base = 'observations';

  // Fyll inn maskinens IP om du kjører på fysisk enhet
  String get _host => Platform.isAndroid ? '10.0.2.2:8082' : 'localhost:8082';

  Map<String, String> _baseHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Uri get _baseUri => Uri.http(_host, _base);
  Uri _idUri(int id) => Uri.http(_host, '$_base/$id');

  Future<Response> deleteObservation(int id) async {
    final response = await delete(
      _idUri(id),
      headers: _baseHeaders,
    );
    return response;
  }

  Future<Observation> createObservation(Observation obs) async {
    final response = await post(
      _baseUri,
      headers: _baseHeaders,
      body: jsonEncode(obs.toJson()),
    );
    if (response.statusCode == 201) {
      return Observation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to create observation $obs due to ${response.statusCode}',
      );
    }
  }

  Future<Observation> updateObservation(int id, Observation obs) async {
    final response = await put(
      _idUri(id),
      headers: _baseHeaders,
      body: jsonEncode(obs.toJson()),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Observation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to update observation with $id due to ${response.statusCode}',
      );
    }
  }

  Future<Observation> getObservation(int id) async {
    final response = await get(_idUri(id));
    if (response.statusCode == 200) {
      return Observation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to retrieve observation with id: $id due to ${response.statusCode}',
      );
    }
  }

  Future<List<Observation>> listObservations() async {
    final response = await get(_baseUri);

    if (response.statusCode == 200) {
      final List<dynamic> array = jsonDecode(response.body);
      return array.map((e) => Observation.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed list observations due to ${response.statusCode}');
    }
  }
}
