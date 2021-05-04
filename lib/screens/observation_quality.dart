import 'package:flutter/material.dart';

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
