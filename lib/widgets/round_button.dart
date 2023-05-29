import 'package:flutter/material.dart';
import 'package:healthcare/constants.dart';

class RoundedIconButton extends StatelessWidget {
  RoundedIconButton({@required this.icon, @required this.onPressed});
  final IconData? icon;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      elevation: 6,
      onPressed: onPressed,
      fillColor: kActiveColor,
      shape: CircleBorder(),
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
    );
  }
}
