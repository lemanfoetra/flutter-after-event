import 'package:flutter/material.dart';
import '../widgets/list_event.dart';
import 'add_event_screen.dart';
import '../providers/add_event/event_provider.dart';
import 'package:provider/provider.dart';
import '../screens/event_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Launch to detail screen
  void _goToDetailScreen(String idEvent) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EventDetailScreen(idEvent: idEvent),
      ),
    );
  }

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
                      idEvent: data[i]['id'],
                      judul: data[i]['judul'],
                      tanggal: DateTime.parse(data[i]['tanggal']),
                      pathImag: data[i]['path_image'],
                      onTap: (idEvent) => _goToDetailScreen(idEvent),
                      deleteFunction: (idEvent) {
                        _showDialog(idEvent);
                      },
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

  /// Show Dialog Konfirmasi ketika Event mau di hapus
  void _showDialog(String idEvent) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Container(
            height: 93,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text('Yakin Hapus?'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: Colors.red,
                      width: 0.5,
                    ),
                  ),
                  child: FlatButton(
                    child: Text(
                      'Oke Hapus',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<EventProvider>(context).deleteEvent(idEvent);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
