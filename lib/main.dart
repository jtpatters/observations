import 'package:flutter/material.dart';
import 'package:observations/database_helper.dart';
import 'package:observations/dimension.dart';
import 'package:observations/dimension_detail.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Observations',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Observations'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Dimension> dimensionList;
  int count = 0;

  void push(String name) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondRoute(name)));
  }

  @override
  Widget build(BuildContext context) {
    if (dimensionList == null) {
      print("list refresh");
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondRoute(
                        this.dimensionList[position].name +
                            " Observation Sentiment")),
              );
            },
          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

class SecondRoute extends StatefulWidget {
  final String recordName;
  const SecondRoute(this.recordName);

  @override
  _SecondRoute createState() => _SecondRoute();
}

class _SecondRoute extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recordName),
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
