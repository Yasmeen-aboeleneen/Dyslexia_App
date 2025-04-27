import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Utils/app_images.dart';
import 'package:dyslexia_app/Views/Home/Tests/letter_discrimination_test.dart';
import 'package:dyslexia_app/Views/Home/Widgets/test_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Image.asset(Assets.imagesPic1),
              SizedBox(
                height: 25,
              ),
              TestCard(
                title: 'اختبار سرعة القراءة',
                description: 'قياس سرعة ودقة القراءة',
                icon: Icons.timer,
                onTap: () {},

                // onTap: () => Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ReadingSpeedTest())),
              ),
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
                title: 'اختبار الذاكرة السمعية',
                description: 'تذكر تسلسل الكلمات',
                icon: Icons.hearing,
                onTap: () {},

                // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AuditoryMemoryTest())),
              ),
              TestCard(
                title: 'اختبار التهجئة',
                description: 'قياس قدرات التهجئة',
                icon: Icons.spellcheck,
                onTap: () {},
                // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SpellingTest())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
