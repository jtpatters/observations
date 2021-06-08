import 'package:observations/database_helper.dart';
import 'package:observations/domain/dimension.dart';
import 'package:observations/screens/dimension_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class ObservationHome extends StatefulWidget {
  ObservationHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ObservationHome createState() => _ObservationHome();
}

class _ObservationHome extends State<ObservationHome> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Dimension> dimensionList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (dimensionList == null) {
      dimensionList = <Dimension>[];
      updateDimensionList();
    }
    print(dimensionList);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.show_chart,
                size: 26.0,
              ),
            )),
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.more_vert),
            )),
      ]),
      body: Container(
        margin: const EdgeInsets.only(bottom: 80.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: getDimensionListView(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: "create",
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          onPressed: () {
            navigateToDetail(new Dimension(''), 'Create Dimension');
          }),
    );
  }

  ListView getDimensionListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Theme.of(context).primaryColorDark,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColorLight,
              child: Text(getFirstLetter(this.dimensionList[position].name),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.dimensionList[position].name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  onTap: () {
                    navigateToDetail(
                        this.dimensionList[position], 'Edit Dimension');
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, '/quality',
                  arguments: {"dim_id": this.dimensionList[position].id});
            },
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void navigateToDetail(Dimension dimension, String title) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DimensionDetail(dimension, title);
    }));

    updateDimensionList();
  }

  void updateDimensionList() {
    print("retrieving list");
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Dimension>> todoListFuture =
          databaseHelper.getDimensionList();
      todoListFuture.then((todoList) {
        setState(() {
          this.dimensionList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }
}
