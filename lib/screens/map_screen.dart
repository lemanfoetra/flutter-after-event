import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

class MapScreen extends StatefulWidget {
  /// Jika true maka map aksinya hanya menampilkan lokasi yang sudah terpilih saja
  final bool isSelected;
  final LatLng targetLocation;
  static const routeName = '/map-screen';

  MapScreen({this.isSelected = false, this.targetLocation});

  @override
  _MapScreenState createState() => new _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _completer = Completer();
  Location location = new Location();
  LatLng _initialLocation = LatLng(-6.914744, 107.609811);
  LatLng _selectedLocation;

  Future<void> _currentCoordinate() async {
    try {
      var _coordinate = await location.getLocation();
      _initialLocation = LatLng(_coordinate.latitude, _coordinate.longitude);
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print("hasil : Permission denied");
      }
    }
  }

  CameraPosition get _targetPosition {
    return CameraPosition(
      target: widget.targetLocation != null
          ? widget.targetLocation
          : _initialLocation,
      zoom: widget.targetLocation != null ? 18 : 12,
    );
  }

  CameraPosition get _newPosition {
    return CameraPosition(
      target: _initialLocation,
      zoom: 22,
    );
  }

  void _useThisCoordinate(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
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
        actions: <Widget>[
          _useThisLocation,
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _targetPosition,
        myLocationEnabled: true,
        onMapCreated: (controller) {
          _completer.complete(controller);
        },
        onTap: (latlng) {
          _useThisCoordinate(latlng);
        },
        markers: _markers,
        gestureRecognizers: Set()
          ..add(
            Factory<EagerGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          ),
      ),
    );
  }

  Set<Marker> get _markers {
    if (!widget.isSelected && _selectedLocation != null) {
      return {
        Marker(
          markerId: MarkerId('m1'),
          position: _selectedLocation,
          infoWindow: InfoWindow(
            title: "Gunakan Lokasi Ini?",
          ),
        ),
      };
    }
    return null;
  }

  Widget get _useThisLocation {
    if (!widget.isSelected && _selectedLocation != null) {
      return IconButton(
        icon: Icon(Icons.check),
        onPressed: () {
          Navigator.of(context).pop<LatLng>(_selectedLocation);
        },
      );
    }
    return Container();
  }
}
