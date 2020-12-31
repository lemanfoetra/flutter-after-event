import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/add_event_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'After Event',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        AddEventScreen.routeName: (ctx) => AddEventScreen(),
      },
    );
  }
}
