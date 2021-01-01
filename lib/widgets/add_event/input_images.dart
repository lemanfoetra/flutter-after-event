import 'package:flutter/material.dart';

class InputImages extends StatefulWidget {
  @override
  _InputImagesState createState() => new _InputImagesState();
}

class _InputImagesState extends State<InputImages> {
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
            child: ListView(
              scrollDirection: Axis.horizontal,
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
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
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
                      _btnActonShowDialog('Camera', Icon(Icons.camera)),
                      _btnActonShowDialog('Gallery', Icon(Icons.photo_album)),
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

  Widget _btnActonShowDialog(String title, Widget iconWidget) {
    return Container(
      margin: EdgeInsets.only(left: 3, right: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: FlatButton(
        onPressed: () {},
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
