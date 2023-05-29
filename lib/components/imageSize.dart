import 'package:flutter/material.dart';

class ImageSize extends StatelessWidget {
  String? imagename;
  double? Width;
  ImageSize({@required this.imagename, this.Width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: AssetImage(imagename.toString()),
        ),
      ), // (
    );
  }
}
