import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Transform.translate(
      offset: Offset(14, 0),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value ?? false;
              });
            },
            checkColor: kveryWhite,
            activeColor: kPrimary3,
            side: BorderSide(color: kPrimary3, width: 2),
          ),
          Expanded(
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'من خلال انشاء حساب فإنك توافق علي',
                  style: GoogleFonts.cairo(
                      color: kDdGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: w * .039)),
              TextSpan(text: ' '),
              TextSpan(
                  text: 'الشروط و الأحكام',
                  style: GoogleFonts.cairo(
                      color: kBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: w * .041)),
              TextSpan(text: ' '),
              TextSpan(
                  text: 'الخاصة بنا',
                  style: GoogleFonts.cairo(
                      color: kBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: w * .041))
            ])),
          )
        ],
      ),
    );
  }
}
