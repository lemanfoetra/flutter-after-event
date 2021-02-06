import 'package:flutter/material.dart';

class MapDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            alignment: Alignment.center,
            child: Text('Location'),
          ),
          Container(
            height: 300,
            color: Colors.green,
            child: Center(
              child: Text('disini map'),
            ),
          )
        ],
      ),
    );
  }
}
