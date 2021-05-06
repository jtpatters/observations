import 'package:flutter/material.dart';
import 'package:observations/domain/dimension.dart';
import 'package:observations/database_helper.dart';
import 'package:toast/toast.dart';

class DimensionDetail extends StatefulWidget {
  final String appBarTitle;
  final Dimension dimension;

  DimensionDetail(this.dimension, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return DimensionDetailState(this.dimension, this.appBarTitle);
  }
}

class DimensionDetailState extends State<DimensionDetail> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Dimension dimension;

  TextEditingController nameController = TextEditingController();

  DimensionDetailState(this.dimension, this.appBarTitle);

  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline4;
    nameController.text = dimension.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: nameController,
                style: textStyle,
                onChanged: (value) {
                  updateName();
                },
                decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColorDark,
                        onPrimary: Color.fromRGBO(255, 255, 255, 0.8),
                        shadowColor: Theme.of(context).primaryColorLight,
                        elevation: 5,
                      ),
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _save();
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Visibility(
                    visible: dimension.id != null,
                    child: Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColorDark,
                          onPrimary: Color.fromRGBO(255, 255, 255, 0.8),
                          shadowColor: Theme.of(context).primaryColorLight,
                          elevation: 5,
                        ),
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _delete();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateName() {
    dimension.name = nameController.text;
  }

  void _save() async {
    Navigator.pop(context, true);

    //todo.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (dimension.id != null) {
      result = await helper.updateDimension(dimension);
    } else {
      result = await helper.insertDimension(dimension);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Dimension Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Dimension');
    }
  }

  void _delete() async {
    Navigator.pop(context, true);
    if (dimension.id == null) {
      _showAlertDialog('Status', 'No Todo was deleted');
      return;
    }

    int result = await helper.deleteDimension(dimension.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Dimension Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Dimension');
    }
  }

  void _showAlertDialog(String title, String message) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}
