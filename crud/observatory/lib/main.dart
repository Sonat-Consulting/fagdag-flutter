import 'package:flutter/material.dart';

import 'package:observatory/pages/observation_page.dart';
import 'package:provider/provider.dart';
import 'package:observatory/state/observation_state.dart';

void main() {
  runApp(ObservationApp());
}

class ObservationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ObservationState()..fetchObservations(),
      child: MaterialApp(
        title: 'Observations',
        theme: ThemeData(
          primaryColor: Colors.blue[900],
          accentColor: Colors.blue[900],
        ),
        home: ObservationPage(),
      ),
    );
  }
}
