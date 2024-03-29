import 'package:flutter/material.dart';

class ObservationQuality extends StatefulWidget {
  //final String recordName;

  @override
  _ObservationQuality createState() => _ObservationQuality();
}

class _ObservationQuality extends State<ObservationQuality> {
  int dim_id;

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> arguments =
        ModalRoute.of(context).settings.arguments;
    dim_id = arguments['dim_id'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Quality"),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 40.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/context',
                        arguments: {"quality": "good", "dim_id": dim_id});
                  },
                  icon: Icon(Icons.sentiment_satisfied_alt, size: 80.0),
                  label: Text('', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/context',
                        arguments: {"quality": "bad", "dim_id": dim_id});
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
