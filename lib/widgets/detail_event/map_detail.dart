import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

class MapDetail extends StatelessWidget {
  final LatLng location;

  MapDetail(this.location);

  CameraPosition get _cameraPosition {
    return CameraPosition(target: location, zoom: 18);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 2, right: 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            height: 300,
            child: GoogleMap(
              initialCameraPosition: _cameraPosition,
              markers: {
                Marker(
                  markerId: MarkerId('m1'),
                  position: location,
                )
              },
              gestureRecognizers: Set()
                ..add(
                  Factory<EagerGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }
}
