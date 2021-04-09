import 'package:flutter/material.dart';
import 'package:observations/screens/observation_home.dart';

void main() {
  runApp(Observations());
}

class Observations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Observations',
      theme: ThemeData.dark(),
      home: ObservationHome(title: 'Observations'),
    );
  }
}
