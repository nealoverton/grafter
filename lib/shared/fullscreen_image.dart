import 'dart:io';

import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  final File imageFile;
  const FullScreenImage({Key? key, required this.imageFile}) : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.file(
          widget.imageFile,
          fit: BoxFit.contain,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
