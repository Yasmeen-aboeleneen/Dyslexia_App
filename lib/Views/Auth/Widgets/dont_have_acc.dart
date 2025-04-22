import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Views/Auth/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({
    super.key,
    required this.w,
  });

  final double w;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: 'لا تمتلك حساب',
          style: GoogleFonts.cairo(
              color: kMGrey, fontWeight: FontWeight.w700, fontSize: w * .048)),
      TextSpan(
          text: " ؟",
          style: GoogleFonts.cairo(
              color: kMGrey, fontWeight: FontWeight.w600, fontSize: w * .045)),
      TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushNamed(context, SignupScreen.signUPRoute);
            },
          text: 'قم بإنشاء حساب',
          style: GoogleFonts.cairo(
              color: kPrimary, fontWeight: FontWeight.w700, fontSize: w * .048))
    ]));
  }
}
