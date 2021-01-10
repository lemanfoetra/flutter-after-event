import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  /// Jika true maka map aksinya hanya menampilkan lokasi yang sudah terpilih saja
  final bool isSelected;
  static const routeName = '/map-screen';

  MapScreen({this.isSelected = false});

  @override
  _MapScreenState createState() => new _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _completer = Completer();
  Location location = new Location();
  LatLng _initialLocation = LatLng(-6.914744, 107.609811);

  Future<void> _currentCoordinate() async {
    try {
      var _coordinate = await location.getLocation();
      setState(() {
        _initialLocation = LatLng(_coordinate.latitude, _coordinate.longitude);
      });
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print("hasil : Permission denied");
      }
    }
  }

  CameraPosition get _newPosition {
    return CameraPosition(
      target: _initialLocation,
      zoom: 16,
    );
  }

  Future<void> _gotoNewPosition() async {
    final GoogleMapController controller = await _completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_newPosition));
  }

  @override
  void initState() {
    _currentCoordinate().then((x) => _gotoNewPosition());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Lokasi'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _initialLocation,
          zoom: 12,
        ),
        myLocationEnabled: true,
        onMapCreated: (controller) {
          _completer.complete(controller);
        },
      ),
    );
  }
}
