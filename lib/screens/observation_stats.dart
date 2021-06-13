import 'package:flutter/material.dart';

class ObservationStats extends StatefulWidget {
  //final String recordName;

  @override
  _ObservationStats createState() => _ObservationStats();
}

class _ObservationStats extends State<ObservationStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stats"),
      ),
    );
  }
}
