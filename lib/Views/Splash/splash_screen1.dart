import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Utils/app_images.dart';
import 'package:dyslexia_app/Views/Splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});
  static const routeName1 = "splash1";

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    executeNavigation();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kveryWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: h * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: kveryWhite,
                  child: Image.asset(
                    Assets.imagesFacultyLogo,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: w * .22),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: kveryWhite,
                  child: Image.asset(
                    Assets.imagesMansouraLogo,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: h * .1),
            Text(
              'Graduation Project',
              style: GoogleFonts.aBeeZee(
                  color: kBlack,
                  fontSize: w * .075,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: h * .05),
            Text(
              'Dyslexia App',
              style: GoogleFonts.aBeeZee(
                  shadows: [
                    Shadow(
                      color: kDGrey,
                      blurRadius: 70,
                    )
                  ],
                  color: kPrimary3,
                  fontSize: w * .08,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: h * .05),
            Text(
              'Supervised by',
              style: GoogleFonts.aBeeZee(
                  color: kRed, fontSize: w * .08, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(right: w * .08, left: w * .08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.justify,
                    'Amany El-Gamal',
                    style: GoogleFonts.aBeeZee(
                        color: kBlue,
                        fontSize: w * .07,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: w * .02),
                  Text(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.justify,
                    'Prof :-',
                    style: GoogleFonts.aBeeZee(
                        color: kBlack,
                        fontSize: w * .06,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: w * .08, left: w * .08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.justify,
                    'Mohamed Ghonem',
                    style: GoogleFonts.aBeeZee(
                        color: kBlue,
                        fontSize: w * .07,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: w * .02),
                  Text(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.justify,
                    'Dr :-',
                    style: GoogleFonts.aBeeZee(
                        color: kBlack,
                        fontSize: w * .06,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * .05),
            Text(
              'Team',
              style: GoogleFonts.aBeeZee(
                  color: kRed, fontSize: w * .07, fontWeight: FontWeight.bold),
            ),
            Text(
              'Yasmeen Abo Eleneen\nWaheed Wael Waked\nAmira Mahmoud Fathy',
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                  color: kBlack,
                  fontSize: w * .06,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  void executeNavigation() {
    Future.delayed(const Duration(seconds: 7), () {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, SplashScreen.routeName);
    });
  }
}
