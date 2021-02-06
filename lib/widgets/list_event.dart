import 'package:flutter/material.dart';
import 'dart:io';

class ListEvent extends StatelessWidget {
  final String idEvent;
  final String judul;
  final DateTime tanggal;
  final String pathImag;
  final Function onTap;
  final Function deleteFunction;

  ListEvent({
    this.idEvent,
    this.judul,
    this.tanggal,
    this.pathImag,
    this.onTap,
    this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: ListTile(
          leading: Container(
            width: 80,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Image.file(
              File(pathImag),
              fit: BoxFit.cover,
            ),
          ),
          title: Text(judul),
          subtitle: Text(tanggal.toString()),
          onTap: () => onTap(idEvent),
          trailing: GestureDetector(
            child: Icon(Icons.delete),
            onTap: () => deleteFunction(idEvent),
          ),
        ),
      ),
    );
  }
}
