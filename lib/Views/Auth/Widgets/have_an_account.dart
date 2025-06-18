import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({
    super.key,
    required this.w,
  });

  final double w;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: 'تمتلك حساب بالفعل',
          style: GoogleFonts.cairo(
              color: kDGrey, fontWeight: FontWeight.w500, fontSize: w * .042)),
      TextSpan(
          text: " ؟",
          style: GoogleFonts.cairo(
              color: kDGrey, fontWeight: FontWeight.w500, fontSize: w * .045)),
      TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pop(context);
            },
          text: ' تسجيل الدخول ',
          style: GoogleFonts.cairo(
              color: kPrimary3,
              fontWeight: FontWeight.w700,
              fontSize: w * .047))
    ]));
  }
}
