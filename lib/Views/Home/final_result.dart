import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalResult extends StatelessWidget {
  const FinalResult({super.key});
  static const finalResult = "finalResult";
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kveryWhite,
      body: Column(
        children: [
          SizedBox(
            height: h * .08,
          ),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: kPrimary3,
              child: Center(
                child: Icon(
                  Icons.person,
                  color: kveryWhite,
                  size: w * .3,
                ),
              ),
            ),
          ),
          SizedBox(
            height: h * .03,
          ),
          Center(
            child: Text(
              'user name',
              style: GoogleFonts.notoNaskhArabic(
                  color: kBlack,
                  fontSize: w * .07,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: h * .02,
          ),
          Expanded(
            child: Container(
              height: h * .1,
              width: w,
              decoration: BoxDecoration(
                  color: kMGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: h * .03,
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            textDirection: TextDirection.rtl,
                            'مستوي صعوبة القراءة لديك :',
                            style: GoogleFonts.notoNaskhArabic(
                                color: kBlack,
                                fontSize: w * .052,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: w * .03,
                        ),
                        Text(
                          'متوسط',
                          style: GoogleFonts.notoNaskhArabic(
                              color: kRed,
                              fontSize: w * .06,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
