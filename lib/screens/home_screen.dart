import 'package:flutter/material.dart';
import '../widgets/list_event.dart';
import 'add_event_screen.dart';
import '../providers/add_event/event_provider.dart';
import 'package:provider/provider.dart';

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
        child: FutureBuilder(
          future:
              Provider.of<EventProvider>(context, listen: false).getListEvent(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              List<Map<String, dynamic>> data = snapshot.data;
              if (data.length > 0) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, i) {
                    return ListEvent(
                      judul: data[i]['judul'],
                      tanggal: DateTime.parse(data[i]['tanggal']),
                      pathImag: data[i]['path_image'],
                    );
                  },
                );
              } else {
                return Center(child: Text('Belum Ada data.'));
              }
            }
            return Center(child: Text('Belum Ada data.'));
          },
        ),
      ),
    );
  }
}
