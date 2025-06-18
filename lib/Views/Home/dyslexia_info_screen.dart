import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Views/Home/Widgets/common_symptoms.dart';
import 'package:dyslexia_app/Views/Home/Widgets/what_is_dyslexia.dart';
import 'package:dyslexia_app/Views/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DyslexiaInfoScreen extends StatelessWidget {
  const DyslexiaInfoScreen({super.key});
static const String dyslexiaInfoRoute = 'dyslexiaInfoRoute';
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kveryWhite,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: WhatisDyslexia(h: h, w: w),
          ),
          Positioned(
              top: h * .32,
              child: SizedBox(
                width: w,
                child: Text(
                  textAlign: TextAlign.center,
                  'الأعراض الشائعة',
                  style: GoogleFonts.cairo(
                      color: kBlack,
                      fontSize: w * .059,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Positioned(
            top: h * .36,
            left: w * .05,
            right: w * .05,
            bottom: h * .01,
            child: CommonSymptoms(
              h: h,
              w: w,
              onNext: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
          )
        ],
      ),
    );
  }
}
