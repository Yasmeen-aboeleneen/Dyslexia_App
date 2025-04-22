import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
     var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
   return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Divider(
            color: kGrey,
            height: h * .05,
            thickness: 1,
          ),
        ),
        SizedBox(
          width: w * .05,
        ),
        Text(
          'أو',
          style: GoogleFonts.cairo(color: kBlack, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: w * .05,
        ),
        Expanded(
            child: Divider(
          color: kGrey,
          height: h * .05,
          thickness: 1,
        ))
      ],
    );
  }
}