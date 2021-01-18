import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../models/event.dart';
import '../../helpers/db_helper.dart';
import '../../models/list_photo.dart';

class EventProvider with ChangeNotifier {
  Uuid uuid = new Uuid();
  List<Event> _listEvent = [];
  List<ListPhoto> _listPoto = [];
  List<Event> get listEvent => [..._listEvent];
  List<ListPhoto> get listPhoto => [..._listPoto];

  /// ADD EVENT
  /// fungsi ini akan menambah ke event objek dan event table
  Future<void> addEvent(Event newEvent) async {
    _listEvent.add(newEvent);

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

  Future<void> tes() async {
    var result = await DBHelper.tesQuery2();
    print(result);
  }
}
