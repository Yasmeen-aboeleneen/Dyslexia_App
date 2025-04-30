// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onpressed,
    required this.text,
  });
  final VoidCallback onpressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      height: h * .065,
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: kPrimary1,
              foregroundColor: kPrimary1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          onPressed: onpressed,
          child: Text(
            text,
            style: GoogleFonts.cairo(
                color: kveryWhite,
                fontSize: w * .052,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
