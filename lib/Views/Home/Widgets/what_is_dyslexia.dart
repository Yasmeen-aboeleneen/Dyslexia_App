import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhatisDyslexia extends StatelessWidget {
  const WhatisDyslexia({
    super.key,
    required this.h,
    required this.w,
  });

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * .28,
      width: w,
      decoration: BoxDecoration(
          color: kPrimary2,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: h * .05,
            ),
            Text(
              'ما هو عسر القراءة ؟',
              style: GoogleFonts.cairo(
                  fontSize: w * .06,
                  color: kveryWhite,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: h * .01,
            ),
            Text(
              textAlign: TextAlign.center,
              'عُسر القراءة هو أحد اضطرابات التعلم، ويشمل صعوبةً في القراءة بسبب وجود مشكلات في التعرف على أصوات الكلام ومعرفة مدى صلتها بالحروف والكلمات ',
              style: GoogleFonts.cairo(
                  color: kveryWhite,
                  fontSize: w * .04,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: h * .01,
            ),
            Text(
                textAlign: TextAlign.center,
                'ولا يحدث عُسر القراءة نتيجة مشكلات تتعلق بالذكاء أو السمع أو البصر',
                style: GoogleFonts.cairo(
                    color: kveryWhite,
                    fontSize: w * .04,
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
