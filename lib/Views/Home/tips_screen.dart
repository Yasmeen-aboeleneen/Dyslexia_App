import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kveryWhite,
      appBar: AppBar(
        backgroundColor: kPrimary3,
        centerTitle: true,
        iconTheme: IconThemeData(color: kveryWhite),
        title: Text(
          'الارشادات',
          style: GoogleFonts.notoNaskhArabic(
            color: kveryWhite,
            fontWeight: FontWeight.bold,
            fontSize: w * .08,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: h * .04,
            ),
            Text(
              textAlign: TextAlign.start,
              "إلي أولياء الأمور ",
              style: GoogleFonts.notoNaskhArabic(
                color: kBlack,
                fontWeight: FontWeight.bold,
                fontSize: w * .05,
              ),
            ),
            SizedBox(
              height: h * .03,
            ),
            Text(
                style: GoogleFonts.notoNaskhArabic(
                  color: kBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: w * .05,
                ),
                textAlign: TextAlign.start,
                '* اقرأ مع طفلك يوميًا لمدة ١٥ دقيقة بصوت واضح ومعبّر\n*استخدم "أسلوب القراءة الثنائية": اقرأ فقرة ثم اطلب منه تكرارها\n*تجنب التصحيح المباشر للأخطاء، بدلًا من ذلك: "هذه الكلمة صعبة، دعنا نقرأها معًا\n')
          ],
        ),
      ),
    );
  }
}
