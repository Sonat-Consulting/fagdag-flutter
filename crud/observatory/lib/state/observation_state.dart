import 'package:observatory/models/observation.dart';
import 'package:flutter/material.dart';

import 'package:observatory/repositories/observation_repository.dart';

class ObservationState extends ChangeNotifier {
  final ObservationRepository _repository;

  List<Observation>? get observations => _observations;
  List<Observation>? _observations;

  ObservationState() : this._repository = ObservationRepository();

  Future<void> fetchObservations() async {
    await list().then((data) {
      _observations = data;
      notifyListeners();
    });
  }

  Future<Observation> create(Observation observation) =>
      _repository.createObservation(observation);

  Future<bool> delete(int id) => _repository
      .deleteObservation(id)
      .then((res) => res.statusCode >= 200 && res.statusCode < 300);

  Future<Observation> update(Observation observation) =>
      _repository.updateObservation(observation);

  Future<Observation> get(int id) => _repository.getObservation(id);

  Future<List<Observation>> list() => _repository.listObservations();
}
