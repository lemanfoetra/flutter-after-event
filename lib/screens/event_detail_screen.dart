import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/add_event/event_provider.dart';
import '../widgets/detail_event/grid_photos.dart';
import '../widgets/detail_event/map_detail.dart';

class EventDetailScreen extends StatefulWidget {
  static const routeName = "/event-detail-screen";
  final String idEvent;

  EventDetailScreen({this.idEvent});

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  Map<String, dynamic> dataEvent = {};
  bool isLoading = true;

  EventProvider _eventProvider({bool listen = false}) {
    return Provider.of<EventProvider>(context, listen: listen);
  }

  /// load Data Event from database
  Future<void> _loadDataEvent(String idEvent) async {
    dataEvent = await _eventProvider().getEventWithId(idEvent);
    print(dataEvent);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _loadDataEvent(widget.idEvent);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isLoading ? Text('Loading...') : Text(dataEvent['judul']),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(2),
                  child: GridPhotos(dataEvent['photos']),
                ),
                Container(
                  child: MapDetail(),
                )
              ],
            ),
    );
  }
}
