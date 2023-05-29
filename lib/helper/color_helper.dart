import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTheme {
  LinearGradient primaryGrad = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(.9, 1),
    colors: <Color>[
      Color(0xff0D41E1),
      Color(0xff0C63E7),
      Color(0xff0A85ED),
      Color(0xff09A6F3),
      Color(0xff9fcaec),
    ],
  );
  Color headerColor = const Color(0xffa9d8e3);
  Color transparent = const Color(0xffECF9FF);
  Color transparent2 = const Color(0xffbceaef);
  Color secondary = const Color(0xff71a9b3);
  Color transparentNav = const Color(0xFFC9CFE0);
  Color primary = const Color(0xff09A6F3);
  Color dark = const Color(0xFF243763);
  Color light = const Color(0xff83b0d4);
  Color border = const Color(0xFFCDB3D4);
  Color subtitle = const Color(0xFF205072);

  Color shimmer_base = Colors.grey.shade50;
  Color shimmer_highlighted = Colors.grey.shade200;
}
