import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Utils/app_images.dart';
import 'package:dyslexia_app/Views/Home/Tests/General_Test/general_test.dart';
import 'package:dyslexia_app/Views/Home/tests_screen.dart';
import 'package:dyslexia_app/Views/Home/tips_screen.dart';
import 'package:dyslexia_app/Views/MainHome/Widgets/custom_container_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kveryWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: h * .05,
          ),
          CircleAvatar(
            radius: w * .3,
            backgroundImage: AssetImage(
              Assets.imagesDownload,
            ),
          ),
          Center(
            child: Text(
              'Discovery',
              style: GoogleFonts.notoNaskhArabic(
                color: kDGrey,
                fontWeight: FontWeight.bold,
                fontSize: w * .1,
              ),
            ),
          ),
          SizedBox(
            height: h * .03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomContainerCard(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReadingTestPage())),
                color: kPrimary3,
                icon: Icons.menu_book_outlined,
                text: 'ابدأ الاختبار',
              ),
            ],
          ),
          SizedBox(
            height: h * .05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomContainerCard(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TestsScreen())),
                color: kPrimary3,
                icon: Icons.voice_chat,
                text: 'ممارسة التدريبات',
              ),
              SizedBox(
                width: w * .03,
              ),
              CustomContainerCard(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TipsScreen())),
                color: kPrimary3,
                icon: Icons.tips_and_updates,
                text: 'الارشادات العامة',
              )
            ],
          )
        ],
      ),
    );
  }
}
