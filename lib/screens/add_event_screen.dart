import 'package:flutter/material.dart';
import '../widgets/add_event/input_images.dart';
import 'package:provider/provider.dart';
import '../providers/add_event/add_image_provider.dart';
import '../models/event.dart';
import '../screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEventScreen extends StatefulWidget {
  static const routeName = "/add-event-screen";

  @override
  _AddEventScreenState createState() => new _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String _judulEvent;
  DateTime _tanggalEvent;
  double _latitudeEvent;
  double _longitudeEvent;
  String _alamatEvent;

  Event _event = Event(
    id: DateTime.now().toString(),
    judul: null,
    tanggal: null,
    latitude: null,
    longitude: null,
    alamat: null,
  );

  final _formKey = GlobalKey<FormState>();

  void _submit() {
    bool status = _formKey.currentState.validate();
    if (status) {
      final _provider = Provider.of<AddImageProvider>(context);
      Event _newEvent = Event(
        id: _event.id,
        judul: _judulEvent,
        tanggal: _tanggalEvent,
        latitude: _latitudeEvent,
        longitude: _longitudeEvent,
        alamat: _alamatEvent,
        saved: 'Y',
      );
    }
  }

  Future<void> _getCoordinate() async {
    LatLng coordinate = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(),
      ),
    );
    setState(() {
      _latitudeEvent = coordinate.latitude;
      _longitudeEvent = coordinate.longitude;
    });
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
              ),
            ),
        ],
      ),
    );
  }
}
