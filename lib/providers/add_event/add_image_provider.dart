import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddImageProvider with ChangeNotifier {

  Future<void> addTempImage(String linkImage) async {
    List<String> newList = [];
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> _oldList = _pref.getStringList('listImageTemp');
    if (_oldList != null) {
      newList = _oldList;
    }
    newList.add(linkImage);
    _pref.setStringList('listImageTemp', newList);
    notifyListeners();
  }

  Future<List<String>> getListTempImage() async {
    List<String> newList = [];
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> _oldList = _pref.getStringList('listImageTemp');
    if (_oldList != null) {
      newList = _oldList;
    }
    return newList;
  }

  Future<String> simpanFileImage(PickedFile imageFile) async {
    final dir = await getApplicationDocumentsDirectory();
    final _fileName = Path.basename(imageFile.path);
    final nameFileImage =
        await File(imageFile.path).copy("${dir.path}/$_fileName");
    return nameFileImage.path;
  }
}
