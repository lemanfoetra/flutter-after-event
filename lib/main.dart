import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/add_event_screen.dart';
import 'package:provider/provider.dart';
import 'providers/add_event/add_image_provider.dart';
import 'providers/add_event/event_provider.dart';
import './screens/map_screen.dart';
import './screens/event_detail_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AddImageProvider()),
          ChangeNotifierProvider(create: (_) => EventProvider()),
        ],
        child: MyApp(),
      ),
    );

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
        MapScreen.routeName: (ctx) => MapScreen(),
        EventDetailScreen.routeName : (ctx) => EventDetailScreen(),
      },
    );
  }
}
