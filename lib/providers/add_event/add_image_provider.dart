import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/event.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddImageProvider with ChangeNotifier {
  List<String> _listTempImage = [];

  List<String> get listTempImage {
    return [..._listTempImage];
  }

  Future<void> addTempImage(String linkImage) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> _oldList = _pref.getStringList('listImageTemp');
    if (_oldList != null) {
      _listTempImage = _oldList;
    }
    _listTempImage.add(linkImage);
    _pref.setStringList('listImageTemp', listTempImage);
    notifyListeners();
    print("ADD TEMP IMAGE");
  }

  Future<List<String>> getListTempImage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> _oldList = _pref.getStringList('listImageTemp');
    if (_oldList != null) {
      _listTempImage = _oldList;
    }
    return listTempImage;
  }

  Future<void> clearTempImage() {}

  Future<String> simpanFileImage(PickedFile imageFile) async {
    final dir = await getApplicationDocumentsDirectory();
    final _fileName = Path.basename(imageFile.path);
    final nameFileImage =
        await File(imageFile.path).copy("${dir.path}/$_fileName");
    return nameFileImage.path;
  }
}
