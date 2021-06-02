import 'package:flutter/material.dart';
import 'package:observatory/state/observation_state.dart';
import 'package:provider/provider.dart';

class ObservationDetailsPage extends StatelessWidget {
  const ObservationDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    return Consumer<ObservationState>(
      builder: (context, state, child) {
        final observation = state.observations!.firstWhere((o) => o.id == id);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(observation.title),
                flexibleSpace: Image.network(
                  observation.imageUrl,
                  fit: BoxFit.cover,
                ),
                expandedHeight: 150.0,
                actions: [
                  IconButton(
                    icon: Icon(Icons.delete_rounded),
                    onPressed: () {
                      // TODO: Implementer sletting av observasjon
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_rounded),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/modify',
                        arguments: observation,
                      );
                    },
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ListTile(
                      title: Text(observation.description ?? ''),
                      subtitle: Text('Description'),
                    ),
                    ListTile(
                      title: Text(observation.userId),
                      subtitle: Text('UserID'),
                    ),
                    ListTile(
                      title: Text('$id'),
                      subtitle: Text('ID'),
                    ),
                    ListTile(
                      title: Text(observation.imageUrl),
                      subtitle: Text('Image URL'),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
