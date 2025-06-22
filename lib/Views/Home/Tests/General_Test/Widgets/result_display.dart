import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultDisplay extends StatelessWidget {
  final String recognizedText;
  final String result;
  final VoidCallback onEvaluate;

  const ResultDisplay({super.key, 
    required this.recognizedText,
    required this.result,
    required this.onEvaluate,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Text(
          "ما تم التعرف عليه:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          recognizedText,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: onEvaluate,
          child: Container(
            width: w * .5,
            height: h * .07,
            decoration: BoxDecoration(
                border: Border.all(color: kPrimary3, width: 3),
                color: kveryWhite,
                borderRadius: BorderRadius.circular(35)),
            child: Center(
              child: Text(
                'تقييم المستوي',
                style: GoogleFonts.notoNaskhArabic(
                    color: kBlack,
                    fontSize: w * .05,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          result,
          style: TextStyle(
              fontSize: w * .08, fontWeight: FontWeight.bold, color: kBlue),
        ),
      ],
    );
  }
}
