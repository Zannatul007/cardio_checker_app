import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/constants.dart';

class IconContent extends StatelessWidget {
  final String? CardLabel;
  final String? CardImage;

  IconContent({@required this.CardLabel, @required this.CardImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(CardImage.toString()),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          CardLabel.toString(),
          style: kCardTextStyle,
        ),
      ],
    );
  }
}
