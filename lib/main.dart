import 'package:flutter/material.dart';
import 'package:observations/screens/observation_home.dart';
import 'package:observations/screens/observation_quality.dart';
import 'package:observations/screens/observation_context.dart';
import 'package:observations/screens/observation_stats.dart';

void main() {
  runApp(Observations());
}

class Observations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Observations',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: ObservationHome(title: 'Observations'),
        routes: <String, WidgetBuilder>{
          '/quality': (BuildContext context) => ObservationQuality(),
          '/context': (BuildContext context) => ObservationContext(),
          '/stats': (BuildContext context) => ObservationStats(),
        });
  }
}
