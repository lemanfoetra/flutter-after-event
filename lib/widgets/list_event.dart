import 'package:flutter/material.dart';

class ListEvent extends StatelessWidget {
  final String judul;
  final DateTime tanggal;
  final String pathImag;

  ListEvent({
    this.judul,
    this.tanggal,
    this.pathImag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Container(
          width: 80,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
        ),
        title: Text(judul),
        subtitle: Text(tanggal.toString()),
      ),
    );
  }
}
