import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

final host = "localhost:8082";

final base = "observations";

Future<http.Response> deleteObservation(int id) async {
  final http.Response response = await http.delete(
    Uri.http(host, '$base/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return response;
}


Future<Observation> createObservation(Observation obs) async {
  final response = await http.post(
    Uri.http(host, base),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userId': obs.userId,
      'title': obs.title,
      'description' : obs.description ?? ""
    }),
  );
  if (response.statusCode == 201) {
    return Observation.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create observation $obs due to $response');
  }
}


Future<Observation> updateObservation(Observation obs) async {
  //TODO Assignment 1, implement this and ensure it is called from the UI and updates the state
  return Future.delayed(Duration(seconds: 2)).then((value) => throw Exception("Not implemented"));
}



Future<Observation> getObservation(int id) async {
  final response = await http.get(Uri.http(host, '$base/$id'));
  if (response.statusCode == 200) {
    return Observation.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to retrieve observation with id: $id due to $response');
  }
}



Future<List<Observation>> listObservations() async {
  final response = await http.get(Uri.http(host, base));
  if (response.statusCode == 200) {
    final List<dynamic> array = jsonDecode(response.body);
    return array
        .map((e) => Observation.fromJson(e))
        .toList();
  } else {
    throw Exception('Failed list observations due to $response');
  }
}