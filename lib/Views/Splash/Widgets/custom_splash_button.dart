import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dyslexia_app/Core/Constants/colors.dart';

class CustomSplashButton extends StatelessWidget {
  const CustomSplashButton({
    super.key,
    required this.text,required this.onTap,  
  });
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        height: h * .09,
        width: w * .24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: kveryWhite,
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.cairo(
                color: kPrimary2,
                fontWeight: FontWeight.bold,
                fontSize: w * .075),
          ),
        ),
      ),
    );
  }
}
