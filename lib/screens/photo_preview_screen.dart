import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';

class PhotoPreviewScreen extends StatelessWidget {
  static const routeName = '/photo-preview-screen';

  @override
  Widget build(BuildContext context) {
    final String urlPatch = ModalRoute.of(context).settings.arguments;
    return Container(
      child: PhotoView(
        imageProvider: FileImage(File(urlPatch)),
      ),
    );
  }
}
