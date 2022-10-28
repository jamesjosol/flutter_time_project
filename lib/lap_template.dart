import 'package:flutter/material.dart';
import 'lap.dart';

class LapTemplate extends StatelessWidget {

  final Lap lap;
  final int index;
  LapTemplate({this.lap, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            index.toString(),
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Text(
            lap.lapTime,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Text(
            lap.mainTime,
            style: TextStyle(
              fontSize: 20.0,
            ),
          )
        ],
      ),
    );
  }
}