import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Utils/app_images.dart';
import 'package:dyslexia_app/Views/OnBoarding/Widgets/page_view_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 
class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    super.key,
    required this.pageController,
   });
  final PageController pageController;
   

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

     

    return PageView(
      controller: pageController,
       
      children: [
        PageViewItem(
          isVisible: true,
          subTitle: "قم بإجراء الاختبارات الصوتية",
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "استمع و ردّد",
                style: GoogleFonts.cairo(
                  color: kPrimary2,
                  fontSize: w * .056,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          image: Assets.imagesPic5,
        ),
        PageViewItem(
          isVisible: false,
          subTitle: "تدرّب على قراءة الكلمات البسيطة",
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "قراءة الكلمات",
                style: GoogleFonts.cairo(
                  color: kPrimary2,
                  fontSize: w * .056,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          image: Assets.imagesPic2,
        ),
        PageViewItem(
          isVisible: false,
          subTitle: "متابعة تقدم الاداء",
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "متابعة ولي الأمر",
                style: GoogleFonts.cairo(
                  color: kPrimary2,
                  fontSize: w * .056,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          image: Assets.imagesPic4,
        ),
      ],
    );
  }
}