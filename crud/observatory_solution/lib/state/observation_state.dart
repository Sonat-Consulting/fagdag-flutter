import 'package:observatory_solution/models/observation.dart';
import 'package:flutter/material.dart';

import 'package:observatory_solution/repositories/observation_repository.dart';

class ObservationState extends ChangeNotifier {
  final ObservationRepository _repository;

  List<Observation>? get observations => _observations;
  List<Observation>? _observations;

  ObservationState() : this._repository = ObservationRepository();

  Future<List<Observation>?> fetchObservations() async {
    await list().then((data) {
      _observations = data;
      notifyListeners();
      return data;
    });
  }

  Observation? find(int id) => _observations?.firstWhere((e) => e.id == id);

  Future<Observation> create(Observation observation) =>
      _repository.createObservation(observation);

  Future<bool> delete(int id) => _repository
      .deleteObservation(id)
      .then((res) => res.statusCode >= 200 && res.statusCode < 300);

  Future<Observation> update(int id, Observation observation) =>
      _repository.updateObservation(id, observation);

  Future<Observation> get(int id) => _repository.getObservation(id);

  Future<List<Observation>> list() => _repository.listObservations();
}
