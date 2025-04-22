import 'package:dyslexia_app/Core/Constants/constants.dart';
import 'package:dyslexia_app/Core/Services/shared_preferences_singleton.dart';
import 'package:dyslexia_app/Views/Auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dyslexia_app/Core/Services/text_to_speech.dart'; // تأكدي من استيراد TextToSpeech
import 'package:dyslexia_app/Core/Constants/colors.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.subTitle,
    required this.title,
    required this.image,
    required this.isVisible,
  });
  final String image;
  final String subTitle;
  final Widget title;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    // قراءة النصوص عند تحميل الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await TextToSpeech.stop(); // إيقاف أي كلام سابق
      await Future.delayed(Duration(milliseconds: 300)); // تأخير بسيط

      // قراءة النص الرئيسي والنص الفرعي
      if (title is Row) {
        // إذا كان title عبارة عن Row (كما في الكود الأصلي)
        final row = title as Row;
        for (final child in row.children) {
          if (child is Text) {
            await TextToSpeech.speak(child.data!); // قراءة النص الرئيسي
          }
        }
      }
      await TextToSpeech.speak(subTitle); // قراءة النص الفرعي
    });

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: h * .5,
          child: Stack(
            children: [
              Positioned(
                top: h * .06,
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              Visibility(
                visible: isVisible,
                child: GestureDetector(
                  onTap: () {
                    SharedPreferencesSingleton.setBool(
                        kIsOnBoardingScreenSeen, true);
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.loginRoute);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'تخط',
                      style: GoogleFonts.cairo(
                          color: kDGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 64,
        ),
        title,
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            subTitle,
            style: GoogleFonts.cairo(
                color: kPrimary2,
                fontSize: w * .040,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}