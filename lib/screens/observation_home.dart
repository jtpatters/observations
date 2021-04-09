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
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
              Navigator.pushNamed(context, '/quality');
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

class ObservationQuality extends StatefulWidget {
  //final String recordName;
  const ObservationQuality();

  @override
  _ObservationQuality createState() => _ObservationQuality();
}

class _ObservationQuality extends State<ObservationQuality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quality"),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 80.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    //Navigator.pop(context);
                    Navigator.pushNamed(context, '/context');
                  },
                  icon: Icon(Icons.sentiment_satisfied_alt, size: 80.0),
                  label: Text('', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    //Navigator.pop(context);
                    Navigator.pushNamed(context, '/context');
                  },
                  icon: Icon(Icons.sentiment_dissatisfied_rounded, size: 80.0),
                  label: Text('', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ObservationContext extends StatefulWidget {
  //final String recordName;
  //final String quality;
  const ObservationContext();

  @override
  _ObservationContext createState() => _ObservationContext();
}

class _ObservationContext extends State<ObservationContext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Context"),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 80.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.sentiment_satisfied_alt, size: 80.0),
                  label: Text('', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.sentiment_dissatisfied_rounded, size: 80.0),
                  label: Text('', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
