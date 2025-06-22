import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Constants/constants.dart';
import 'package:dyslexia_app/Core/Services/shared_preferences_singleton.dart';
import 'package:dyslexia_app/Core/Services/text_to_speech.dart';
import 'package:dyslexia_app/Core/Utils/app_images.dart';
import 'package:dyslexia_app/Views/Auth/login_screen.dart';
import 'package:dyslexia_app/Views/OnBoarding/onboarding_screen.dart';
import 'package:dyslexia_app/Views/Splash/Widgets/custom_splash_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimary3,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: h * .56,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(250),
                  bottomRight: Radius.circular(250),
                ),
                color: kveryWhite,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(Assets.imagesLogo),
                ),
              ),
            ),
          ),
          Positioned(
            top: h * .67,
            left: w * .2,
            right: w * .2,
            child: Center(
              child: AnimatedOpacity(
                opacity: _animation.value,
                duration: Duration(seconds: 1),
                child: Text(
                  "Discovery",
                  style: GoogleFonts.notoNaskhArabic(
                    color: kveryWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: w * .1,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: w * .25,
            right: w * .25,
            bottom: h * .08,
            child: CustomSplashButton(
              text: "ابدأ",
              onTap: () async {
                await TextToSpeech.speak('ابدأ');
                await Future.delayed(Duration(seconds: 1));
                excuteNavigation();
              },
            ),
          ),
        ],
      ),
    );
  }

  void excuteNavigation() async {
    bool isOnBoardingScreenSeen =
        SharedPreferencesSingleton.getBoo(kIsOnBoardingScreenSeen);
    await Future.delayed(const Duration(seconds: 3));
    if (isOnBoardingScreenSeen) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, LoginScreen.loginRoute);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, OnboardingScreen.onBoardingRoute);
    }
  }
}
