import 'package:observations/database_helper.dart';
import 'package:observations/domain/dimension.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class ObservationStats extends StatefulWidget {
  @override
  _ObservationStats createState() => _ObservationStats();
}

class _ObservationStats extends State<ObservationStats> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int observationCount = -1;
  List<Dimension> dimensionList;

  @override
  Widget build(BuildContext context) {
    if (observationCount < 0) getObservationCount();
    if (dimensionList == null) {
      dimensionList = <Dimension>[];
      updateDimensionList();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Stats"),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: Text(buildText())));
  }

  String buildText() {
    String str = "Observations: " + observationCount.toString();
    str += "\n\n";
    for (int i = 0; i < dimensionList.length; i++) {
      str += dimensionList[i].name;
      str += "\t";
      str += dimensionList[i].observations.toString();
      str += "\n";
    }
    return str;
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

  void updateDimensionList() {
    print("retrieving list");
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Dimension>> dimListFuture =
          databaseHelper.getDimensionListWithObservationCounts();
      dimListFuture.then((dimList) {
        setState(() {
          this.dimensionList = dimList;
        });
      });
    });
  }
}
