import 'package:observations/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class ObservationStats extends StatefulWidget {
  @override
  _ObservationStats createState() => _ObservationStats();
}

class _ObservationStats extends State<ObservationStats> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int observationCount = -1;

  @override
  Widget build(BuildContext context) {
    if (observationCount < 0) getObservationCount();
    return Scaffold(
        appBar: AppBar(
          title: Text("Stats"),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: Text("Observations: " + observationCount.toString())));
  }

  getObservationCount() {
    print("retrieving observation count");
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<int> obsCountFuture = databaseHelper.getObservationCount();
      obsCountFuture.then((obsCount) {
        print(obsCount);
        setState(() {
          observationCount = obsCount;
        });
      });
    });
  }
}
