import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../widgets/add_event/input_images.dart';
import '../models/event.dart';
import '../screens/map_screen.dart';
import '../providers/add_event/event_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

class AddEventScreen extends StatefulWidget {
  static const routeName = "/add-event-screen";

  @override
  _AddEventScreenState createState() => new _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _judulController = TextEditingController();
  double _latitudeEvent;
  double _longitudeEvent;
  String _alamatEvent;

  /// Inisite Class Uuid untuk pembuatan unix id row table
  Uuid uuid = new Uuid();

  /// Membuat Objek Event Provider
  EventProvider get _eventProvider {
    return Provider.of<EventProvider>(context, listen: false);
  }

  /// Submit Event
  Future<void> _submit() async {
    final idEvent = uuid.v1();
    bool status = _formKey.currentState.validate();
    if (status) {
      Event _newEvent = Event(
        id: idEvent,
        alamat: _alamatEvent,
        judul: _judulController.text,
        latitude: _latitudeEvent,
        longitude: _longitudeEvent,
        tanggal: DateTime.now(),
      );

      /// save event
      await _eventProvider.addEvent(_newEvent);
      Navigator.of(context).pop();
    }
  }

  Future<void> _getCoordinate() async {
    LatLng coordinate = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(),
      ),
    );
    if (coordinate != null) {
      setState(() {
        _latitudeEvent = coordinate.latitude;
        _longitudeEvent = coordinate.longitude;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _submit(),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.save, color: Colors.white),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            _inputJudul(),
            InputImages(),
            _inputLokasi(),
          ],
        ),
      ),
    );
  }

  Widget _inputJudul() {
    return Container(
      child: Form(
        key: _formKey,
        child: Container(
          child: TextFormField(
            decoration: InputDecoration(labelText: "Judul Event"),
            validator: (value) {
              if (value.isEmpty) {
                return "Judul Perlu diisi";
              }
              return null;
            },
            controller: _judulController,
          ),
        ),
      ),
    );
  }

  Widget _inputLokasi() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () => _getCoordinate(),
            child: Container(
              child: Text(
                'Lokasi Event',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              width: double.infinity,
            ),
            color: Colors.teal,
          ),
          if (_latitudeEvent != null && _longitudeEvent != null)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
              margin: EdgeInsets.only(top: 10),
              height: 400,
              width: double.infinity,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(_latitudeEvent, _longitudeEvent),
                  zoom: 20,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('marker1'),
                    position: LatLng(_latitudeEvent, _longitudeEvent),
                  )
                },
                gestureRecognizers: Set()
                  ..add(
                    Factory<EagerGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  ),
              ),
            ),
        ],
      ),
    );
  }
}
