import 'package:flutter/material.dart';
import 'dart:io';

class GridPhotos extends StatelessWidget {
  final List<Map<String, dynamic>> photos;

  GridPhotos(this.photos);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 15, bottom: 10),
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Photos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 110,
              childAspectRatio: 1,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: photos.length,
            itemBuilder: (ctx, i) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                ),
                width: double.infinity,
                height: double.infinity,
                child: Image.file(
                  File(photos[i]['path_image']),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
