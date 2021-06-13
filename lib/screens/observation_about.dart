import 'package:flutter/material.dart';

class ObservationAbout extends StatefulWidget {
  //final String recordName;

  @override
  _ObservationAbout createState() => _ObservationAbout();
}

class _ObservationAbout extends State<ObservationAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
    );
  }
}
