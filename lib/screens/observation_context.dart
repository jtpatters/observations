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
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> arguments =
        ModalRoute.of(context).settings.arguments;
    observation = new Observation();
    observation.quality = arguments['quality'];
    observation.dimId = arguments['dim_id'];
    print(arguments['quality']);
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
                  controller: myController,
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
                      observation.comments = myController.text;
                      print(observation.toMap());
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
    Navigator.pop(context);
    Navigator.pop(context);

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
