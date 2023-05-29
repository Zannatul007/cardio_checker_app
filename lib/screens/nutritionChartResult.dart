import 'package:flutter/material.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/widgets/reusableCard.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// void recommendChart(result) {
//   if (result <= 1000) {
//     SfPdfViewer.network(
//         'https://drive.google.com/file/d/1uhQJv9IaDBkxEXxqKGg-0zwK5jc__DTY/view?usp=share_link');
//   } else if (result > 1000 && result <= 1200) {
//     SfPdfViewer.network(
//         'https://drive.google.com/file/d/1uhQJv9IaDBkxEXxqKGg-0zwK5jc__DTY/view?usp=share_link');
//   } else if (result > 1200 && result <= 1800) {
//     SfPdfViewer.network(
//         'https://drive.google.com/file/d/1yV0D9KSSaV2Pg9kEBq0GcPlqrMYX2LmC/view?usp=share_link');
//   } else {
//     SfPdfViewer.network(
//         'https://drive.google.com/file/d/1Qe7l6e5mSeWvU-_-JgqwY_X56Or95FpX/view?usp=share_link');
//   }
// }

class RecommendedChart extends StatefulWidget {
  final double CalorieResult;
  const RecommendedChart({required this.CalorieResult});

  @override
  State<RecommendedChart> createState() => _RecommendedChartState();
}

class _RecommendedChartState extends State<RecommendedChart> {
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (widget.CalorieResult! <= 1000) {
      child = SfPdfViewer.asset('pdf/below100.pdf');
    } else if (widget.CalorieResult! > 1000 && widget.CalorieResult! <= 1200) {
      child = SfPdfViewer.asset('pdf/1000-1200.pdf');
    } else if (widget.CalorieResult! > 1200 && widget.CalorieResult! <= 1800) {
      child = SfPdfViewer.asset('pdf/1601-1800.pdf');
    } else {
      child = SfPdfViewer.asset('pdf/above1800.pdf');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kActiveColor,
        centerTitle: true,
        title: Text(
          'Your Nutrition Chart',
          style: kCardTextStyle,
        ),
      ),
      body: Container(
        child: child,
      ),
    );
    // // // body: Text(widget.CalorieResult.toString()),
    // body: SfPdfViewer.asset('pdf/below100.pdf'),
    // body: (() {
    //   if (widget.CalorieResult! <= 1000) {
    //     SfPdfViewer.asset('pdf/below100.pdf');
    //   } else if (widget.CalorieResult! > 1000 &&
    //       widget.CalorieResult! <= 1200) {
    //     SfPdfViewer.asset('pdf/1000-1200.pdf');
    //   } else if (widget.CalorieResult! > 1200 &&
    //       widget.CalorieResult! <= 1800) {
    //     SfPdfViewer.asset('pdf/1601-1800.pdf');
    //   } else {
    //     SfPdfViewer.asset('pdf/above1800.pdf');
    //   }
    // }()),
  }
}
