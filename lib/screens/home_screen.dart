import 'package:flutter/material.dart';
import '../widgets/list_event.dart';
import 'add_event_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event History'),
        actions: <Widget>[
          FlatButton(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Add Event',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AddEventScreen.routeName);
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListEvent(
              judul: "Judul Event",
              tanggal: DateTime.now(),
              pathImag: '',
            ),
            ListEvent(
              judul: "Judul Event",
              tanggal: DateTime.now(),
              pathImag: '',
            ),
          ],
        ),
      ),
    );
  }
}
