import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProgressIndicator extends StatelessWidget {
  final int current;
  final int total;

  const CustomProgressIndicator({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        LinearProgressIndicator(
          color: kBlack,
          backgroundColor: kveryWhite,
          value: current / total,
        ),
        SizedBox(
          height: h * .03,
        ),
        Text(
          'السؤال $current من $total',
          style: GoogleFonts.cairo(
              color: kBlack, fontWeight: FontWeight.bold, fontSize: w * .06),
        ),
      ],
    );
  }
}
