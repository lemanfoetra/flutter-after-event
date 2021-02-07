import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../models/event.dart';
import '../../helpers/db_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class EventProvider with ChangeNotifier {
  Uuid uuid = new Uuid();

  /// ADD EVENT
  /// fungsi ini akan menambah ke event objek dan event table
  Future<void> addEvent(Event newEvent) async {
    // Simpan Event ke db
    await DBHelper.insert('event', {
      'id': newEvent.id,
      'judul': newEvent.judul,
      'tanggal': newEvent.tanggal.toString(),
      'latitude': newEvent.latitude,
      'longitude': newEvent.longitude,
      'alamat': newEvent.alamat,
    });

    // Simpan Photo List Ke Db
    final List<String> listPhoto = await _getListPhoto();
    if (listPhoto.length > 0) {
      for (int i = 0; i < listPhoto.length; i++) {
        await DBHelper.insert('list_photo', {
          'id': uuid.v1(),
          'event_id': newEvent.id,
          'path_image': listPhoto[i],
        });
      }
    }
    notifyListeners();
  }

  /// Mengambil list photo yang ada di shared frefences,
  /// dan kemudian menghapusnya
  Future<List<String>> _getListPhoto() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> data = _pref.getStringList('listImageTemp');

    // hapus photo list di sharedprefencis
    await _pref.remove('listImageTemp');
    return data;
  }

  /// GET LIST EVENT
  Future<List<Map<String, dynamic>>> getListEvent() async {
    return await DBHelper.getListEvent();
  }

  /// DELETE EVENT WITH ID
  Future<void> deleteListWithId(String id) async {
    await DBHelper.deleteEventWithId(id);
  }

  Future<void> truncateTable(String table) async {
    await DBHelper.truncateTable(table);
  }

  Future<Map<String, dynamic>> getEventWithId(String idEvent) async {
    final eventResult = await DBHelper.getEventWithId(idEvent);
    final listPhotos = await DBHelper.getPhotosEventWithIdEvent(idEvent);
    Map<String, dynamic> eventData;
    if (eventResult.length > 0) {
      eventData = eventResult[0];
      if (listPhotos.length > 0) {
        eventData = {
          ...eventData,
          'photos': listPhotos,
        };
      }
    }
    return eventData;
  }

  Future<String> get _getLokalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// HAPUS EVENT
  Future<void> deleteEvent(String idEvent) async {
    // DELETE file photos
    final listImagePhoto = await DBHelper.getPhotosEventWithIdEvent(idEvent);
    if (listImagePhoto.length > 0) {
      for (int i = 0; i < listImagePhoto.length; i++) {
        File fileToDelete = File(listImagePhoto[i]['path_image']);
        try {
          await fileToDelete.delete();
          print('success deleted files');
        } catch (e) {
          print("error deleted files");
        }
      }
    }
    // DELETE  di database
    await DBHelper.deleteEvent(idEvent);
    notifyListeners();
  }
}
