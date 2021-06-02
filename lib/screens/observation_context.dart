import 'package:flutter/material.dart';
import 'package:observations/domain/observation.dart';
import 'package:observations/database_helper.dart';
import 'package:toast/toast.dart';

class ObservationContext extends StatefulWidget {
  //final String recordName;
  //final String quality;
  const ObservationContext();

  @override
  _ObservationContext createState() => _ObservationContext();
}

class _ObservationContext extends State<ObservationContext> {
  DatabaseHelper helper = DatabaseHelper();
  Observation observation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Context"),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 40.0),
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 0),
                child: Text('Observation Context:'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3, //Normal textInputField will be displayed
                  maxLines: 5, // when user presses enter it will adapt to it
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: ''),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
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
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    Navigator.pushNamed(context, '/home');

    //todo.date = DateFormat.yMMMd().format(DateTime.now());
    int result;

    result = await helper.insertObservation(observation);

    if (result != 0) {
      _showAlertDialog('Status', 'Observation Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Observation');
    }
  }

  void _showAlertDialog(String title, String message) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}
