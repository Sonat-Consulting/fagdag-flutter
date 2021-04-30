import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('no.sonat.demo/native');
  String _batteryLevel = 'Unknown';
  String _osVersion = 'Unknown';

  void _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = result.toString();
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    } on Exception catch (e) {
      batteryLevel = "Unexpected exception: ${e.toString()}";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  void _getOsVersion() async {
    String osVersion;
    try {
      final String result = await platform.invokeMethod('getOsVersion');
      osVersion = result;
    } on PlatformException catch (e) {
      osVersion = "Failed to get os version: '${e.message}'.";
    } on Exception catch (e) {
      osVersion = "Unexpected exception: ${e.toString()}";
    }

    setState(() {
      _osVersion = osVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Battery level is:',
                ),
                Text(
                  '$_batteryLevel',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Os version is:',
                ),
                Text(
                  '$_osVersion',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: Text("Update battery level"),
            ),
            ElevatedButton(
              onPressed: _getOsVersion,
              child: Text("Update OS version"),
            ),
          ], // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
