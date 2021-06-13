import 'package:flutter/material.dart';

class ObservationSettings extends StatefulWidget {
  //final String recordName;

  @override
  _ObservationSettings createState() => _ObservationSettings();
}

class _ObservationSettings extends State<ObservationSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
    );
  }
}
