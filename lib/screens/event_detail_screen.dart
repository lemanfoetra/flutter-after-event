import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  static const routeName = "/event-detail-screen";
  final String idEvent;

  EventDetailScreen({this.idEvent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$idEvent"),
      ),
      body: Container(),
    );
  }
}
