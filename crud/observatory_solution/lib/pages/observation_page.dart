import 'package:observatory_solution/models/observation.dart';
import 'package:observatory_solution/state/observation_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObservationPage extends StatelessWidget {
  Future<void> onRefresh(ObservationState state) async {
    await state.fetchObservations();
  }

  void onObservationCreated(BuildContext context, Observation? observation) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Observation ${observation?.title} added 🔭'),
    ));
  }

  void onError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$message 💥'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ObservationState>(
      builder: (context, state, child) {
        if (state.observations == null) {
          state.fetchObservations().catchError(
            (e) {
              onError(context, 'Failed to fetch observations');
            },
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Observations'),
          ),
          body: RefreshIndicator(
            onRefresh: () => onRefresh(state),
            child: ObservationList(observations: state.observations),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_rounded),
            onPressed: () => Navigator.of(context).pushNamed('/modify').then(
                  (result) =>
                      onObservationCreated(context, result as Observation),
                ),
          ),
        );
      },
    );
  }
}

class ObservationList extends StatelessWidget {
  final List<Observation>? observations;

  const ObservationList({Key? key, required this.observations})
      : super(key: key);

  int get count => observations?.length ?? 0;

  @override
  Widget build(BuildContext context) {
    if (observations != null) {
      return ListView.builder(
        itemCount: observations!.length,
        itemBuilder: (context, index) {
          final observation = observations![index];

          return ObservationTile(observation: observation);
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class ObservationTile extends StatelessWidget {
  ObservationTile({
    Key? key,
    required this.observation,
  }) : super(key: key);

  final Observation observation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.black12, width: 0.5),
        ),
      ),
      child: ListTile(
        title: Text(observation.title),
        subtitle: Text(observation.description ?? ''),
        trailing: Container(
          width: 72.0,
          height: double.infinity,
          child: Image.network(observation.imageUrl, fit: BoxFit.cover),
        ),
        onTap: () => Navigator.of(context).pushNamed(
          '/details',
          arguments: observation.id,
        ),
      ),
    );
  }
}
