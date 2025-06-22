import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ControlButtons extends StatelessWidget {
  final VoidCallback onSpeak;
  final VoidCallback onRecord;
  final bool isListening;

  const ControlButtons({super.key, 
    required this.onSpeak,
    required this.onRecord,
    required this.isListening,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: h * .03,
        ),
        GestureDetector(
          onTap: onSpeak,
          child: Container(
            width: w * .5,
            height: h * .07,
            decoration: BoxDecoration(
                color: kPrimary3, borderRadius: BorderRadius.circular(35)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'استمع للنص',
                    style: GoogleFonts.notoNaskhArabic(
                        color: kveryWhite,
                        fontSize: w * .05,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: w * .02,
                  ),
                  Icon(
                    Icons.volume_up,
                    color: kveryWhite,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        GestureDetector(
          onTap: onRecord,
          child: Container(
            width: w * .5,
            height: h * .07,
            decoration: BoxDecoration(
                color: kPrimary3, borderRadius: BorderRadius.circular(35)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isListening ? 'إيقاف التسجيل' : 'بدء التسجيل',
                    style: GoogleFonts.notoNaskhArabic(
                        color: kveryWhite,
                        fontSize: w * .05,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: w * .04,
                  ),
                  Icon(
                    isListening ? Icons.stop : Icons.mic,
                    color: kveryWhite,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
