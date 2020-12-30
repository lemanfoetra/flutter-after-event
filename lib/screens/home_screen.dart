import 'package:flutter/material.dart';
import '../widgets/list_event.dart';

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
