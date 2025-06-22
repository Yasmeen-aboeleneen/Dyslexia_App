import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Views/Home/Tests/Letter_Discrimination_Test/letter_discrimination_test.dart';
import 'package:dyslexia_app/Views/Home/Tests/Phonological_Test/phonological_test.dart';
import 'package:dyslexia_app/Views/Home/Tests/Spelling_Test/spelling_test_screen.dart';
import 'package:dyslexia_app/Views/Home/Widgets/test_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimary3,
        body: Column(
          children: [
            Container(
                height: h * .12,
                width: w,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 35,
                          color: kveryWhite,
                          offset: Offset(0, 10))
                    ],
                    color: kDGrey,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35))),
                child: Center(
                    child: Text(
                  'Discovery',
                  style: GoogleFonts.cairo(
                    color: kveryWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: w * .088,
                  ),
                ))),
            SizedBox(
              height: h * .06,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "مجموعة من الاختبارات المصممة بعناية التي تساعد في علاج صعوبات القراءة (عُسر القراءة) ",
                style: GoogleFonts.cairo(
                  color: kveryWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: w * .04,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: h * .09,
            ),
            Expanded(
              child: Container(
                width: w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                    color: kDGrey,
                    boxShadow: [
                      BoxShadow(
                          color: kveryWhite,
                          blurRadius: 50,
                          offset: Offset(0, 10))
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: h * .05,
                        ),
                        TestCard(
                          title: 'تدريبات التمييز بين الحروف',
                          description: 'تمييز الحروف المتشابهة',
                          icon: Icons.text_fields,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VoiceLetterTest())),
                        ),
                        SizedBox(
                          height: h * .05,
                        ),
                        TestCard(
                          title: 'تدريبات التهجئة',
                          description: 'قياس قدرات التهجئة',
                          icon: Icons.spellcheck,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VoiceSpellingTest())),
                        ),
                        SizedBox(
                          height: h * .05,
                        ),
                        TestCard(
                          title: 'تدريبات الوعي الصوتي',
                          description: 'القدرة على التلاعب بالمقاطع الصوتية',
                          icon: Icons.record_voice_over,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PhonologicalTestScreen())),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
