import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/add_event/add_image_provider.dart';
import 'dart:io';

class InputImages extends StatefulWidget {
  @override
  _InputImagesState createState() => new _InputImagesState();
}

class _InputImagesState extends State<InputImages> {
  final ImagePicker _imagePicker = new ImagePicker();

  AddImageProvider _addImageProvider({bool listen = false}) {
    return Provider.of<AddImageProvider>(context, listen: listen);
  }

  Future<void> _onGetImagePressed(ImageSource imageSource) async {
    //try {
    PickedFile _pickedFile = await _imagePicker.getImage(
      source: imageSource,
    );
    String fileName = await _addImageProvider().simpanFileImage(_pickedFile);
    print(fileName);

    await _addImageProvider().addTempImage(fileName);
    Navigator.of(context).pop();
    //} catch (e) {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: AlignmentDirectional.centerStart,
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Foto Event',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            height: 110,
            width: double.infinity,
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () => _showDialog(),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Icon(Icons.add_a_photo, color: Colors.black54),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _addImageProvider().getListTempImage(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return Consumer<AddImageProvider>(
                          child: Container(),
                          builder: (ctx, provider, ch) {
                            List<String> listData = provider.listTempImage;
                            return listData.length <= 0
                                ? ch
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: listData.length,
                                    itemBuilder: (ctx, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            File(listData[index]),
                                            filterQuality: FilterQuality.low,
                                            fit: BoxFit.cover,
                                          ),
                                          margin: EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 0.5),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Container(
            height: 100,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text('Ambil gambar dari?'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _btnActonShowDialog(
                          'Camera', Icon(Icons.camera), ImageSource.camera),
                      _btnActonShowDialog('Gallery', Icon(Icons.photo_album),
                          ImageSource.gallery),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _btnActonShowDialog(
      String title, Widget iconWidget, ImageSource imageSource) {
    return Container(
      margin: EdgeInsets.only(left: 3, right: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: FlatButton(
        onPressed: () => _onGetImagePressed(imageSource),
        child: Row(
          children: <Widget>[
            iconWidget,
            Container(
              child: Text(title),
              margin: EdgeInsets.only(left: 10),
            )
          ],
        ),
      ),
    );
  }
}
