import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Views/Home/Widgets/common_symptoms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.widget,
  });

  final CommonSymptoms widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: ElevatedButton(
        onPressed: widget.onNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: kDGrey,
          padding: EdgeInsets.symmetric(
            horizontal: widget.w * 0.3,
            vertical: widget.h * 0.015,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          'التالي',
          style: GoogleFonts.cairo(
            color: kveryWhite,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
