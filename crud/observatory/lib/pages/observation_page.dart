import 'package:observatory/models/observation.dart';
import 'package:observatory/state/observation_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_observation_page.dart';

class ObservationPage extends StatefulWidget {
  @override
  _ObservationPageState createState() => _ObservationPageState();
}

class _ObservationPageState extends State<ObservationPage> {
  Future<void> onRefresh(ObservationState state) async {
    // TODO: Implementer refresh-mekanisme
    await Future.delayed(Duration(seconds: 1));
  }

  void onObservationCreated(Observation observation) {
    // TODO: Oppdater listen med nytt element
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Observation added 🔭'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ObservationState>(
      builder: (context, state, child) {
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
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddObservationPage(
                  onObservationCreated: onObservationCreated,
                ),
              ),
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

  @override
  Widget build(BuildContext context) {
    if (observations != null) {
      return ListView.builder(
        itemCount: observations!.length,
        itemBuilder: (context, index) {
          final observation = observations![index];

          return ObservationTile(
            observation: observation,
            onDelete: (toDelete) {
              if (toDelete.id != null) {
                Provider.of<ObservationState>(context).delete(toDelete.id!);
              }
            },
            onUpdate: (toUpdate) {
              // TODO Implement assignment 1
            },
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class ObservationTile extends StatefulWidget {
  ObservationTile({
    Key? key,
    required this.observation,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  final Observation observation;
  final Function(Observation) onDelete;
  final Function(Observation) onUpdate;

  @override
  _ObservationTileState createState() => _ObservationTileState();
}

class _ObservationTileState extends State<ObservationTile> {
  bool edit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(widget.observation.title),
        subtitle: Text(widget.observation.description ?? ''),
        leading: Image.asset('images/globular.png'),
      ),
    );
  }
}
