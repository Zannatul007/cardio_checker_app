import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? ButtonLabel;
  final onTapFunc;
  Color? color;
  Button({@required this.ButtonLabel, @required this.onTapFunc, this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunc,
      child: Container(
        height: 50,
        child: Center(
          child: Text(
            ButtonLabel.toString(),
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(1, 1),
            colors: <Color>[
              Color(0xff0D41E1),
              Color(0xff0A85ED),
              Color(0xff09A6F3),
              Color(0xff07C8F9),
            ],
          ),
        ),
        width: double.infinity,
        margin: EdgeInsets.all(15),
      ),
    );
  }
}
