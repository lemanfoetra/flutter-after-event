import 'package:flutter/material.dart';

class Event {
  final String id;
  final String judul;
  final DateTime tanggal;
  final double latitude;
  final double longitude;
  final String alamat;

  Event({
    @required this.id,
    @required this.judul,
    @required this.tanggal,
    @required this.latitude,
    @required this.longitude,
    @required this.alamat,
  });
}
