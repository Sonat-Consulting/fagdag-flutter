import 'package:flutter/material.dart';
import 'package:observatory_solution/pages/modify_observation_page.dart';
import 'package:observatory_solution/pages/observation_details_page.dart';

import 'package:observatory_solution/pages/observation_page.dart';
import 'package:observatory_solution/state/image_state.dart';
import 'package:provider/provider.dart';
import 'package:observatory_solution/state/observation_state.dart';

void main() {
  runApp(ObservatoryApp());
}

class ObservatoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ObservationState(),
        ),
        ChangeNotifierProvider(
          create: (_) => ImageState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Observations',
        theme: ThemeData(
          primaryColor: Colors.blue[900],
          accentColor: Colors.blue[900],
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => ObservationPage(),
          '/modify': (_) => ModifyObservationPage(),
          '/details': (_) => ObservationDetailsPage(),
        },
      ),
    );
  }
}
