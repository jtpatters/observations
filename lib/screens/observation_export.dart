import 'package:flutter/material.dart';

class ObservationExport extends StatefulWidget {
  //final String recordName;

  @override
  _ObservationExport createState() => _ObservationExport();
}

class _ObservationExport extends State<ObservationExport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export"),
      ),
    );
  }
}
