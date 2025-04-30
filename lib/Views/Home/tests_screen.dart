import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Views/Home/Tests/Letter_Discrimination_Test/letter_discrimination_test.dart';
import 'package:dyslexia_app/Views/Home/Tests/Phonological_Test/phonological_test.dart';
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
        backgroundColor: kPrimary1,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: h * .1,
                width: w,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 25,
                          color: kveryWhite,
                          offset: Offset(0, 10))
                    ],
                    color: kveryWhite,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35))),
                child: Center(
                    child: Text(
                  'Discovery',
                  style: GoogleFonts.cairo(
                    color: kPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: w * .088,
                  ),
                ))),
            SizedBox(
              height: h * .02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "مجموعة من الاختبارات المصممة بعناية التي تساعد في الكشف المبكر عن صعوبات القراءة (عُسر القراءة) وتحديد مستوياتها بدقة\n مما يمهد الطريق لتقديم الدعم والتدخل المناسب لكل حالة.",
                style: GoogleFonts.cairo(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: w * .04,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: h * .04,
            ),
            Expanded(
              child: Container(
                width: w,
                decoration: BoxDecoration(color: kPrimary),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TestCard(
                          title: 'اختبار التمييز بين الحروف',
                          description: 'تمييز الحروف المتشابهة',
                          icon: Icons.text_fields,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VoiceLetterTest())),
                        ),
                        TestCard(
                          title: 'اختبار سرعة القراءة',
                          description: 'قياس سرعة ودقة القراءة',
                          icon: Icons.timer,
                          onTap: () {},
                          // onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ReadingTestPage())),
                        ),
                        TestCard(
                          title: 'اختبار الذاكرة السمعية',
                          description: 'تذكر تسلسل الكلمات',
                          icon: Icons.hearing,
                          onTap: () {},
                          // onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ArabicMemoryScreen())),
                        ),
                        TestCard(
                          title: 'اختبار التهجئة',
                          description: 'قياس قدرات التهجئة',
                          icon: Icons.spellcheck,
                          onTap: () {},
                          // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SpellingTest())),
                        ),
                        TestCard(
                          title: 'اختبار الوعي الصوتي',
                          description: 'القدرة على التلاعب بالمقاطع الصوتية',
                          icon: Icons.record_voice_over,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PhonologicalTestScreen())),
                        )
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
