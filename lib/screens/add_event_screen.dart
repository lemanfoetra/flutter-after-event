import 'package:flutter/material.dart';
import '../widgets/add_event/input_images.dart';
import 'package:provider/provider.dart';
import '../providers/add_event/add_image_provider.dart';
import '../models/event.dart';

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
}
